#!/bin/bash
# Lint + unit tests, then the lint findings that are not UnusedResources. Run before every commit.
# MODULE defaults to :app.
set -eo pipefail
cd "$(dirname "$0")/.."
MODULE=${MODULE:-:app}
dir=${MODULE#:}
./gradlew "$MODULE:lintDebug" "$MODULE:testDebugUnitTest" -q 2>&1 | { grep -v '^w: \|Wrote .* report' || true; }
python3 - "$dir/build/reports/lint-results-debug.sarif" <<'PY'
import json, sys
results = json.load(open(sys.argv[1]))["runs"][0]["results"]
found = False
for r in results:
    if r["ruleId"] == "UnusedResources":
        continue
    found = True
    loc = r.get("locations", [{}])[0].get("physicalLocation", {})
    print(r.get("level", "warning"), r["ruleId"], r["message"]["text"][:200],
          loc.get("artifactLocation", {}).get("uri", ""), loc.get("region", {}).get("startLine", ""))
sys.exit(1 if found else 0)
PY
# Every key in values/strings.xml exists in each translation (translatable="false" excepted).
python3 - "$dir/src/main/res" <<'PY'
import glob, os, sys, xml.etree.ElementTree as ET
res = sys.argv[1]
def keys(path):
    root = ET.parse(path).getroot()
    return {e.get("name") for e in root if e.tag in ("string", "plurals", "string-array") and e.get("translatable") != "false"}
base = keys(os.path.join(res, "values", "strings.xml"))
missing = []
for path in glob.glob(os.path.join(res, "values-*", "strings.xml")):
    for key in sorted(base - keys(path)):
        missing.append(f"{os.path.basename(os.path.dirname(path))}: {key}")
if missing:
    print("Missing translations:\n" + "\n".join(missing))
    sys.exit(1)
PY
tools/check-stamp.sh write
echo OK

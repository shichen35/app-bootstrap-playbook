#!/bin/zsh
# Fails when a String Catalog has a key without a translation in $LANGS (default zh-Hans).
set -euo pipefail
root=${0:A:h:h}
APP=${APP:-MyApp}
LANGS=${LANGS:-zh-Hans}
catalogs=($root/$APP/**/*.xcstrings(N) $root/${APP}Widget/**/*.xcstrings(N) $root/Config/*.xcstrings(N))
python3 - "$LANGS" $catalogs <<'PY'
import json, os, sys
langs = sys.argv[1].split(",")
missing = []
for path in sys.argv[2:]:
    for key, value in json.load(open(path))["strings"].items():
        if value.get("shouldTranslate") is False or not key.strip():
            continue
        for lang in langs:
            if lang not in value.get("localizations", {}):
                missing.append(f"{os.path.basename(path)} [{lang}]: {key!r}")
if missing:
    print("Missing translations:\n" + "\n".join(missing))
    sys.exit(1)
PY

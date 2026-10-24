#!/bin/zsh
# Merges the strings the last build extracted from source into the String Catalogs, as Xcode's
# IDE does on build (xcodebuild does not), then drops strings the source no longer uses.
# Run after an app build into build/DerivedData. Targets: $APP and ${APP}WidgetExtension.
set -euo pipefail
root=${0:A:h:h}
APP=${APP:-MyApp}
objects=$root/build/DerivedData/Build/Intermediates.noindex/$APP.build/Debug-iphonesimulator
for target catalog in "$APP" "$APP/Localizable.xcstrings" "${APP}WidgetExtension" "${APP}Widget/Localizable.xcstrings"; do
    [[ -f $root/$catalog ]] || continue
    data=($objects/$target.build/Objects-normal/arm64/*.stringsdata(N))
    (( ${#data} )) && xcrun xcstringstool sync "$root/$catalog" --stringsdata $data
    python3 - "$root/$catalog" <<'PY'
import json, sys
path = sys.argv[1]
catalog = json.load(open(path))
catalog["strings"] = {k: v for k, v in catalog["strings"].items() if v.get("extractionState") != "stale"}
with open(path, "w") as f:
    json.dump(catalog, f, ensure_ascii=False, indent=2, separators=(",", " : "), sort_keys=True)
    f.write("\n")
PY
done

#!/bin/zsh
# Builds, installs and launches the debug app on a simulator, opens a screen through the app's
# DebugLaunch hook (-screen <name>) and saves a screenshot scaled to 1200 px.
# Usage: tools/shot.sh <output.png> [screen] [device] [extra launch args...]
# Env: APP (scheme), BUNDLE (bundle id), SEED (file copied into Application Support/$APP/ on a
# fresh install, e.g. demo data), SEED_NAME (its name there), SHOT_DELAY (seconds, default 6),
# DEVICE (simulator name; `xcrun simctl list devices available` lists them).
set -euo pipefail
root=${0:A:h:h}
APP=${APP:-MyApp}
BUNDLE=${BUNDLE:-com.example.myapp}
out=$1; screen=${2:-list}; device=${3:-${DEVICE:?set DEVICE or pass a simulator name}}; shift $(( $# < 3 ? $# : 3 ))
cd "$root"
xcrun simctl boot "$device" 2>/dev/null || true
xcodebuild -project "$APP.xcodeproj" -scheme "$APP" -destination "platform=iOS Simulator,name=$device" \
    -derivedDataPath build/DerivedData -quiet build
xcrun simctl install "$device" "build/DerivedData/Build/Products/Debug-iphonesimulator/$APP.app"
xcrun simctl terminate "$device" "$BUNDLE" 2>/dev/null || true
if [[ -n ${SEED:-} ]]; then
    data=$(xcrun simctl get_app_container "$device" "$BUNDLE" data)
    dest="$data/Library/Application Support/$APP/${SEED_NAME:-${SEED:t}}"
    if [[ ! -f $dest ]]; then
        mkdir -p "${dest:h}"
        cp "$SEED" "$dest"
    fi
fi
xcrun simctl launch "$device" "$BUNDLE" -screen "$screen" "$@" >/dev/null
sleep ${SHOT_DELAY:-6}
tmp=$(mktemp -t shot).png
xcrun simctl io "$device" screenshot "$tmp" >/dev/null 2>&1
sips -Z 1200 "$tmp" --out "$out" >/dev/null
rm -f "$tmp"
echo "$out"

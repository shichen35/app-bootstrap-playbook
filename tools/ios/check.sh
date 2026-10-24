#!/bin/zsh
# Lint, package tests, an app build that fails on any warning in our sources, and the String
# Catalog check. Run before every commit and look at the exit code.
# Set APP (scheme and project name) and KIT (local Swift package path) for your project.
set -euo pipefail
root=${0:A:h:h}
APP=${APP:-MyApp}
KIT=${KIT:-Packages/MyAppKit}
cd "$root"

echo "== swift format lint"
xcrun swift-format lint --strict --recursive --parallel "$APP" ${APP}Widget(N) "$KIT/Sources" "$KIT/Tests" "$KIT/Package.swift" tools/*.swift(N)

echo "== package tests"
swift test --package-path "$KIT" -q 2>&1 | tail -3

echo "== app build"
# Some diagnostics stay warnings despite SWIFT_TREAT_WARNINGS_AS_ERRORS, so fail on any warning
# in our own sources. Removing the app target's intermediates recompiles every file.
rm -rf "build/DerivedData/Build/Intermediates.noindex/$APP.build"
log=$(xcodebuild -project "$APP.xcodeproj" -scheme "$APP" -destination 'generic/platform=iOS Simulator' \
    -derivedDataPath build/DerivedData -quiet build CODE_SIGNING_ALLOWED=NO 2>&1) || { echo "$log"; exit 1; }
warnings=$(echo "$log" | grep -E "^$root/.*: warning:" | grep -v "/build/" | sort -u || true)
if [[ -n $warnings ]]; then
    echo "$warnings"
    exit 1
fi

echo "== localization"
APP=$APP tools/sync-strings.sh
APP=$APP tools/check-strings.sh

echo "OK"

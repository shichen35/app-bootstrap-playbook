# Scripts

app-scaffold copies these into a new project's `tools/`.

| Script | Purpose | Parameters |
|---|---|---|
| `ios/check.sh` | swift-format lint, package tests, app build (fails on any warning in this repo's sources), String Catalog sync and translation check | `APP` (scheme / project name / source directory name), `KIT` (local package path) |
| `ios/sync-strings.sh` | After a build, merges the extracted strings into `.xcstrings` (xcodebuild doesn't) and removes stale ones | `APP` |
| `ios/check-strings.sh` | Fails if any key is missing a translation | `APP`, `LANGS` (comma-separated, default `zh-Hans`) |
| `ios/translate.py` | Batch-writes translations from JSON into a String Catalog | `<catalog> [lang] < json` |
| `ios/shot.sh` | Builds, installs, seeds demo data, opens a screen via `-screen`, takes a screenshot and scales it to 1200 px | `APP`, `BUNDLE`, `DEVICE`, `SEED`, `SEED_NAME`, `SHOT_DELAY` |
| `ios/make-icon.swift` | Draws a 1024 app icon with no alpha | Edit `drawArtwork(in:)` |
| `ios/swift-format.json` | swift-format config (copy to `.swift-format` at the repo root) | — |
| `common/check-stamp.sh` | When `check.sh` passes, records a fingerprint of the working tree (excluding Markdown); the pre-commit hook uses it to confirm the checks ran after the last code change | `write` / `verify` |
| `android/check.sh` | lint + unit tests; prints any lint findings other than UnusedResources (and fails if there are any); checks that every language's strings.xml is complete | `MODULE` (default `:app`) |

In the new project, hardcode defaults such as `APP` and `KIT` at the top of each script instead of passing environment variables every time.

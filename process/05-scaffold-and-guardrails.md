# 05 · Scaffold and guardrails: project, CLAUDE.md, check script

Goal: the very first code commit installs both the rules the agent follows every session and the checks every commit must pass. From then on, quality rests on those two things, not on anyone's memory.

## Project scaffold

| Platform | Approach |
|---|---|
| Android | Copy an existing project's layout: single `:app` module, `libs.versions.toml` version catalog, compileSdk / targetSdk, JVM target, `extraWarnings`. ADR-0001 records whose layout we followed and why multi-module / Room were rejected. |
| iOS | Hand-write `project.pbxproj` (objectVersion 77 with a **folder sync group**, `PBXFileSystemSynchronizedRootGroup`, so adding or removing files never touches the project file); put pure logic in a local Swift Package (`Packages/<Kit>`) that the app and widgets depend on; keep Info.plist fragments in `Config/` (outside the synced folder, so they aren't copied as resources); use a shared scheme (the StoreKit configuration has to be attached to it). |
| macOS / CLI | A single Swift Package with multiple targets (core library, app, CLI); `scripts/build-app.sh` packages the .app. |

Draw the app icon with a script (`tools/make-icon.swift`). iOS requires 1024×1024, no alpha, full bleed.

## CLAUDE.md (template [templates/CLAUDE.md](../templates/CLAUDE.md))

Three sections:

1. **One-line project description + tech stack**.
2. **Commands**: build, check, unit tests, device tests, screenshots.
3. **Hard rules**: one line each, drawn from the ADRs' red lines and project conventions, for example:
   - Commits: one-line Conventional Commit, no body, no attribution; one commit per task, with the task list checkbox in the same commit.
   - The pure-logic layer must not import platform frameworks.
   - State changes only on the serial context.
   - Layout is window-only.
   - Colors come only from theme tokens / semantic colors; status never relies on color alone.
   - Every user-facing string exists in English and Simplified Chinese.
   - Decisions and problems go into `doc/decisions.md`.
   - Simulator rules (which device, window visible, never create or delete AVDs).
4. **Where to look** table: question → which file to read.

## Check script `tools/check.sh`

Must pass before every commit. Contents by platform (ready-made scripts in [tools/](../tools/)):

| Step | Android | iOS |
|---|---|---|
| Format / lint | `./gradlew :app:lintDebug`, then filter `UnusedResources` out of the SARIF and print the rest | `swift format lint --strict` (ships with Xcode; no SwiftLint needed) |
| Unit tests | `:app:testDebugUnitTest` | `swift test --package-path Packages/<Kit>` |
| Build | Already built by lint | `xcodebuild … build`, then **scan the output for `warning:` in this repo's sources** (some concurrency warnings ignore warnings-as-errors) |
| Localization | Every key exists in every language's `strings.xml` | After the build, `xcstringstool sync` merges the extracted strings into the String Catalog and removes stale ones; then check that every key has zh-Hans |

## Gate

- [ ] `tools/check.sh` passes on the empty project.
- [ ] `CLAUDE.md`, `doc/dev-progress.md` and `doc/decisions.md` exist.
- [ ] First commit: `build: …`.

## Lessons

- Unlike the Xcode IDE, `xcodebuild` doesn't sync strings into `.xcstrings`. Run `xcstringstool sync` yourself, or missing translations go unnoticed.
- Pipes swallow exit codes: `tools/check.sh | tail -1 && git commit` commits even when the checks fail. Either `set -o pipefail`, or write the output to a file first and then check the exit code.
- Without a shared scheme, xcodebuild generates one automatically and prints "Supported platforms … is empty". That's noise.

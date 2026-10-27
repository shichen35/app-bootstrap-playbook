---
name: app-scaffold
description: Scaffold a buildable empty native app project with its guardrails - CLAUDE.md with hard rules, tools/check.sh (lint, unit tests, build that fails on warnings, localization completeness), doc/dev-progress.md task list with milestones and doc/decisions.md log - using the check and screenshot scripts bundled with this skill. Use for "scaffold the project", "create an empty project", "write CLAUDE.md", "add a check script", after the spec is approved, or when a port needs its new repo set up.
---

# Scaffold and guardrails

Install two things in the very first code commit: the rules the agent follows every time, and the checks every commit must pass. From then on, quality rests on these two, not on memory.

Read `doc/feature-requirements.md`, `doc/tech-spec.md` and `doc/adr/README.md` first. If they don't exist, stop and suggest running app-spec first.

## 1. Project

| Platform | Approach |
|---|---|
| Android | Copy the layout of an existing project: single module `:app`, a `libs.versions.toml` version catalog, compileSdk / targetSdk, JVM target, `extraWarnings`. ADR-0001 records which project you followed and what you rejected. |
| iOS | Hand-write `project.pbxproj` (objectVersion 77, with `PBXFileSystemSynchronizedRootGroup` folder-synced groups so adding or removing files never touches the project file). Put pure logic in a local Swift package (`Packages/<Kit>`) that the app and its extensions depend on; put Info.plist fragments in `Config/`; share the scheme. |
| macOS / CLI | A single Swift package with several targets (core library, app, CLI); `scripts/build-app.sh` bundles the .app. |

## 2. Check script `tools/check.sh`

Copy `scripts/<platform>/` from this skill's directory into the project's `tools/`, and hardcode defaults such as `APP` and `KIT` at the top. See [scripts/README.md](scripts/README.md) for what each script does and its parameters.

| Step | Android | iOS |
|---|---|---|
| Format / lint | `:app:lintDebug`; fail if anything remains after filtering out `UnusedResources` | `swift format lint --strict` |
| Unit tests | `:app:testDebugUnitTest` | `swift test --package-path Packages/<Kit>` |
| Build | Already built by lint | `xcodebuild … build`, plus a scan of this repo's sources for `warning:` |
| Localization | Every key exists in each language's `strings.xml` | `xcstringstool sync` merges strings into the String Catalog, then every key is checked for a translation |

For iOS, also copy `shot.sh` (screenshots), `sync-strings.sh`, `check-strings.sh` and `translate.py`, and copy `swift-format.json` to `.swift-format` at the repo root. Draw the app icon with `make-icon.swift` (1024×1024, no alpha, full bleed).

## 3. Docs

- `CLAUDE.md`: use [CLAUDE-FORMAT.md](CLAUDE-FORMAT.md). One line per hard rule, drawn from the ADR red lines and project conventions.
- `doc/dev-progress.md`: use [DEV-PROGRESS-FORMAT.md](DEV-PROGRESS-FORMAT.md). Break the FRs and tech-spec into tasks, one commit's worth of work per line; suffix each task name with its FR-n and mark milestones with ★.
- `doc/decisions.md`: use [DECISION-LOG-FORMAT.md](DECISION-LOG-FORMAT.md). D-001 records which project the scaffold follows.

## Done when

- You have pasted the output of `tools/check.sh > /tmp/check.log 2>&1; echo $?` on the empty project, and the exit code is 0.
- `CLAUDE.md`, `doc/dev-progress.md` and `doc/decisions.md` exist.
- The first commit is `build: …`: one line, no body, no attribution.

## Pitfalls

- `xcodebuild` doesn't sync strings into `.xcstrings`. Run `xcstringstool sync` yourself, or missing translations go unnoticed.
- Pipes swallow the failure code: `tools/check.sh | tail -1 && git commit` commits even when the check fails. Write the output to a file first, then check the exit code.
- Without a shared scheme, xcodebuild prints "Supported platforms … is empty". It's noise.

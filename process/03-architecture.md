# 03 · Architecture: tech-spec, ADRs, performance research

Goal: before any code is written, settle the layers, boundaries, key data flows and every significant trade-off, and write down the "why" in docs that both the agent and humans can consult at any time.

For the how-to, see the [app-spec](../skills/app-spec/SKILL.md) Skill; the formats are in `TECH-SPEC-FORMAT.md`, `ADR-FORMAT.md` and `PERFORMANCE-FORMAT.md` in its directory.

## Why we hold to these structures

- **Pure-logic core**: parsing, engines, statistics, export and rule tables live in a module with no dependency on the UI framework (on Android, `core/` must not import `android.*`; on iOS, it's a local Swift Package). Its full test suite runs in seconds on a dev machine, so every commit runs it, and another platform in the same language can copy it over wholesale.
- **Single command entry point**: one Model / Store singleton that ViewModels, notification actions, background jobs and widget deep links all call. With only one way in, monetization gates, logging and undo each have an obvious home.
- **State changes on one serial context only** (a Swift actor / a single-threaded Kotlin dispatcher); I/O callbacks just enqueue work. No locks, and no races.
- **Snapshots with structural sharing**: the UI pulls a snapshot every few hundred milliseconds; unchanged rows reuse the same object, and equality is id + revision. Even a list of thousands of rows never gets a full redraw.
- **Monetization gates sit where the action runs** (creation, backup jobs, widget refresh), not in the UI, so actions arriving from notifications, deep links or widgets can't bypass them.

## Why ADRs carry red lines

An ADR's "Red lines" section is copied into the hard rules in `CLAUDE.md`, which the agent reads at the start of every session; the ADR itself may not get read every time. "When to revisit" tells future maintainers what would justify overturning the decision.

A typical first batch of ADRs: whose project layout to follow, minimum OS version, concurrency model, snapshot model, background strategy, window-adaptation rules, permissions, and no shell execution.

## Performance research

Start from an existing implementation (or industry practice) and work item by item: "original approach → how this platform does it → why, or why it doesn't apply → decision". The Example App's performance research covered data (paging, full-text indexing, write coalescing), reminder scheduling (only the nearest batch is scheduled), UI (snapshots, projections, list rows that skip recomposition) and background work (WorkManager constraints, BGAppRefreshTask). The design points are in [08](08-performance.md).

## Lessons

- Across platforms, **copy whenever you can**. Two platforms in the same language (e.g. macOS and iOS) copy the core package and its tests directly, and tests that pass unchanged prove the port is correct. Across languages (Kotlin ↔ Swift) you have to rewrite from the tech-spec, but the test scenarios carry over as is.
- When you copy instead of depending on another repo, record the upstream commit hash (`UPSTREAM.md`) and sync bug fixes by hand.

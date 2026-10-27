# 03 · Architecture: tech-spec, ADRs, performance research

Goal: before any code is written, settle the layers, boundaries, key data flows and every significant trade-off, and write down the "why" in docs that both the agent and humans can consult at any time.

## Outputs

- `doc/tech-spec.md` (template [app-spec/TECH-SPEC-FORMAT.md](../skills/app-spec/TECH-SPEC-FORMAT.md))
- `doc/adr/NNNN-<short-title>.md` + a `doc/adr/README.md` index (template [app-spec/ADR-FORMAT.md](../skills/app-spec/ADR-FORMAT.md))
- `doc/performance-research.md` (for performance-sensitive projects; template [app-spec/PERFORMANCE-FORMAT.md](../skills/app-spec/PERFORMANCE-FORMAT.md))

## Skeleton of the tech-spec

1. The tech stack in one sentence (single module / single Activity / MVVM / DI / UI framework / navigation / package name), plus which existing project's layout it follows (ADR-0001).
2. **Layer diagram** (ASCII or Mermaid): UI → state / command entry point → data and system integration → **pure-logic core** → platform implementations.
3. One section per layer: responsibilities, key types, concurrency model, and data structure choices with their rationale.
4. Window-adaptation rules (based on window width and height only).
5. Monetization hooks (if any): gates sit **where the action runs**, not in the UI.
6. Test strategy and common commands.

## Structures to hold to

- **Pure-logic core**: parsing, engines, statistics, export and rule tables live in a module with no dependency on the UI framework (on Android, `core/` must not import `android.*`; on iOS, it's a local Swift Package). It has full unit test coverage that runs in seconds on a dev machine.
- **Single command entry point**: one Model / Store singleton that ViewModels, notification actions, background jobs and widget deep links all call.
- **State changes on one serial context only** (a Swift actor / a single-threaded Kotlin dispatcher); I/O callbacks just enqueue work.
- **Snapshots with structural sharing**: the UI pulls a snapshot every few hundred milliseconds; unchanged rows reuse the same object, and equality is id + revision.

## ADR rules

- At most 40 lines each, in four sections: **Decision** · **Rejected alternatives** · **Red lines** · **When to revisit**.
- Numbers only increase. When an ADR is superseded, note "Partly superseded by NNNN" at the top; never delete the old one.
- Mechanisms belong in the code and the tech-spec; an ADR records only the why.
- Copy each ADR's "Red lines" into the hard rules in `CLAUDE.md` (the agent reads that every session).
- A typical first batch of ADRs: whose project layout to follow, minimum OS version, concurrency model, snapshot model, background strategy, window-adaptation rules, permissions, and no shell execution.

## Performance research

Start from an existing implementation (or industry practice) and work item by item: "original approach → how this platform does it → why, or why it doesn't apply → decision". The Example App's performance research covered data (paging, full-text indexing, write coalescing), reminder scheduling (only the nearest batch is scheduled), UI (snapshots, projections, list rows that skip recomposition) and background work (WorkManager constraints, BGAppRefreshTask).

## Gate

- [ ] Every arrow in the layer diagram has a settled direction (who depends on whom).
- [ ] The pure-logic layer's boundary is written as a red line.
- [ ] Every trade-off someone might question has an ADR, including the rejected options.
- [ ] A human has reviewed each ADR's status (proposed → accepted).

## Lessons

- Across platforms, **copy whenever you can**. Two platforms in the same language (e.g. macOS and iOS) copy the core package and its tests directly, and tests that pass unchanged prove the port is correct. Across languages (Kotlin ↔ Swift) you have to rewrite from the tech-spec, but the test scenarios carry over as is.
- When you copy instead of depending on another repo, record the upstream commit hash (`UPSTREAM.md`) and sync bug fixes by hand.

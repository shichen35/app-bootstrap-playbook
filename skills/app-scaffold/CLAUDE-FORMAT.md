# CLAUDE.md

{{APP_NAME}} {{one sentence: what it does, and for whom}}. {{platform}}: {{tech stack, e.g. single module `:app`, single Activity, MVVM + Hilt, Compose / Material 3 Expressive, Navigation 3 / SwiftUI + Observation, iOS 26+, Liquid Glass, Swift 6}}. Package name / bundle ID `{{com.example.app}}`. {{for a port: features follow the FR-n in ../<other platform>/doc/feature-requirements.md; engine code comes from ../<other platform>}}.

## Commands

```bash
{{build command}}
tools/check.sh                 # lint + unit tests + build + localization, before every commit
{{command to test a single class / the package}}
{{on-device test command}}
tools/shot.sh out.png <screen> # debug screenshot (see DebugLaunch)
```

## Hard rules

- **Commits**: one line, Conventional Commits (`type(scope): subject`). No body, no trailers, no attribution. One task per commit; tick it in `doc/dev-progress.md` in the same commit.
- Every decision and every problem hit goes into `doc/decisions.md` (D-n / P-n); lasting trade-offs also get an ADR in `doc/adr/` (four sections, ≤ 40 lines).
- `{{core module path}}` is pure {{Kotlin / Swift}}: no {{android.* / UIKit / SwiftUI}} imports. Everything in it has tests.
- {{engine / state}} is touched only on its serial context ({{actor / single-threaded dispatcher}}). I/O callbacks only enqueue.
- Snapshot rows are immutable and reused when unchanged.
- Layout adapts to the window only ({{window width / horizontalSizeClass}}), never the device model.
- Colors: theme tokens / semantic colors only; every status also has an icon.
- Every user-facing string in English **and** {{Simplified Chinese / other languages}} ({{per-language strings.xml directories / String Catalogs}}).
- {{monetization red lines: a downgrade never changes data; running tasks are never interrupted; no scheduled upsells; the ad SDK is never initialized for one-time-purchase users}}
- {{other ADR red lines, one per line}}

## Emulator / Simulator

- All on-device checks run on {{device name}}, window visible. Never create or delete devices without asking.
- {{notes on special postures / permissions / network testing}}

## Where to look

| Question | Read |
|---|---|
| What the app does (FR-n) | [doc/feature-requirements.md](doc/feature-requirements.md) |
| Architecture | [doc/tech-spec.md](doc/tech-spec.md) |
| Decisions | [doc/adr/README.md](doc/adr/README.md), [doc/decisions.md](doc/decisions.md) |
| What is done / next | [doc/dev-progress.md](doc/dev-progress.md) |
| Vocabulary | [CONTEXT.md](CONTEXT.md) |

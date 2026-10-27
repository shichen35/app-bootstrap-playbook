---
name: app-spec
description: Write the spec set for an app before any product code - numbered feature requirements (FR-n) with a platform mapping table and a "not doing" section, a CONTEXT.md glossary, a tech-spec with a layer diagram and a pure-logic core, ADRs (four sections, at most 40 lines), a performance research doc and a single-file HTML mock. Use for "feature requirements", "tech spec", "architecture design", "write an ADR", "performance research", "UI mock".
---

# Requirements, glossary, architecture, mock

Write docs in the user's language unless they ask otherwise.

## Before you start

If any of the idea, target users, platforms and minimum OS, monetization intent or red lines are still open: Call the Skill tool with "grilling", and ask only about these. If that skill isn't available, ask all of them in one message. If `doc/competitor-analysis.md` exists, read its conclusions and requirement candidates first.

## Requirements `doc/feature-requirements.md`

Use [FR-FORMAT.md](FR-FORMAT.md).

- State the baseline and its date at the top.
- Platform mapping table: one row per mechanism that differs from the baseline, with the reason.
- Group FR-n by user goal. Each FR-n.m is one testable sentence with numeric bounds and interaction details ("requires the user to tick it explicitly", "merges within half a second", "at most 50,000 entries per import").
- Free / Pro gets its own group that cites the ADR; spell out the downgrade rules.
- A "Not doing, and why" section is mandatory.
- Only append numbers; never renumber.

## Glossary and ADRs

Call the Skill tool with "domain-modeling": use its approach to challenge each term, force out definitions with edge cases, and decide which trade-offs deserve an ADR. This project's file formats differ from its defaults; where they conflict, follow this skill:

- The glossary is `CONTEXT.md` at the repo root (not `GLOSSARY.md`), using [CONTEXT-FORMAT.md](CONTEXT-FORMAT.md). All platforms share one.
- ADRs go in `doc/adr/` (not `docs/adr/`), with four fixed sections and at most 40 lines, using [ADR-FORMAT.md](ADR-FORMAT.md).
- Give a reason for each rejected option; copy red lines into the Hard rules in CLAUDE.md.
- Status starts as proposed; change it to accepted once the user confirms. When an ADR is superseded, mark it; don't delete it.

Without `domain-modeling`: write an ADR for every trade-off that might be challenged, and define each term in one sentence that states its boundary and the near-synonyms to "avoid".

## Architecture `doc/tech-spec.md`

Use [TECH-SPEC-FORMAT.md](TECH-SPEC-FORMAT.md).

- The tech stack in one sentence + the reference project it follows (ADR-0001).
- A layer diagram; each layer's responsibilities, key types, concurrency model and data structures, with the reasons.
- Pure-logic core: no UI framework dependency, fully unit-tested.
- Single command entry point; state changes only on a serial context; snapshots use structural sharing.
- Layout is window-only; monetization gates sit where the action executes.
- Testing strategy and commands.

## Performance research (when performance matters)

Write `doc/performance-research.md` using [PERFORMANCE-FORMAT.md](PERFORMANCE-FORMAT.md). For each item: "source approach → how this platform does it → differences → decision (including the trigger for anything deferred)". End with a measurements table and references.

## Mock `doc/mock/ui-mock.html`

- One self-contained HTML file: plain HTML/CSS/JS, no dependencies, fixed demo data.
- Canvases side by side for the main screen, detail, add, settings and the wide two-pane layout, covering narrow, wide and short windows.
- Draw it in the target platform's design language; encode status twice, with color plus icon.
- Humans review the mock, not the code.

## Done when

- Every FR is testable and has numeric bounds; there is a "Not doing, and why" section.
- The layering direction is clear; the pure-logic layer's boundary is written as a red line.
- Every key trade-off has an ADR, including the rejected options.
- The mock covers the main task flows and all three window shapes.

In your reply to the user, list the docs and the ADRs that need a decision (with their options). Don't start writing product code.

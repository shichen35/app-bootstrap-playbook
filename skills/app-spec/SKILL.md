---
name: app-spec
description: Write the spec set for an app - numbered feature requirements (FR-n) with a platform mapping table and a "not doing" section, a CONTEXT.md glossary, a tech-spec with a layer diagram and a pure-logic core, ADRs (four sections, at most 40 lines), and a performance research doc. Use for "feature requirements", "tech spec", "architecture design", "write an ADR", "performance research", or phases 2-3 of app-bootstrap.
---

# Requirements, glossary, architecture, ADRs

Process: `<playbook>/process/02-requirements.md`, `03-architecture.md`. Templates in `templates/`: `feature-requirements.md`, `CONTEXT.md`, `tech-spec.md` (`architecture-port.md` for a port), `adr/0000-template.md`, `adr/README.md`, `performance-research.md`.

## Requirements (doc/feature-requirements.md)

- State the baseline and its date at the top.
- Platform mapping table: one row per mechanism that differs from the baseline, with the reason.
- Group FR-n by user goal. Each FR-n.m is one testable sentence with numeric bounds and interaction details ("requires the user to tick it explicitly", "merges within half a second", "at most 50,000 entries per import").
- Free / Pro gets its own group that cites the ADR; spell out the downgrade rules.
- A "Not doing, and why" section is mandatory.
- Only append numbers; never renumber.

## Glossary (CONTEXT.md)

For each domain concept: **Term (Simplified Chinese)**: definition. _Avoid_: near-synonyms. All platforms share one.

## Architecture (doc/tech-spec.md)

- The tech stack in one sentence + the reference project it follows (ADR-0001).
- A layer diagram; each layer's responsibilities, key types, concurrency model and data structures, with the reasons.
- Pure-logic core: no UI framework dependency, fully unit-tested.
- Single command entry point; state changes only on a serial context; snapshots use structural sharing.
- Layout is window-only; monetization gates sit where the action executes.
- Testing strategy and commands.

## ADR (doc/adr/NNNN-*.md)

- At most 40 lines, four sections: Decision · Rejected alternatives · Red lines · When to revisit.
- One per trade-off that "might be challenged"; give a reason for each rejected option.
- Copy red lines into the Hard rules in CLAUDE.md.
- Status starts as proposed; change it to accepted once the user confirms. When an ADR is superseded, mark it; don't delete it.
- Update the index table in `doc/adr/README.md`.

## Performance research (when performance matters)

For each item: "source approach → how this platform does it → differences → decision (including the trigger for anything deferred)". End with a measurements table and references.

## Wrap-up

Give the user the list of docs and the ADRs that need their decision. Don't start writing product code.

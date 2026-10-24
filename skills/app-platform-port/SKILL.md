---
name: app-platform-port
description: Build an independent native implementation of an existing app on another platform (e.g. iOS SwiftUI from Android Kotlin and macOS Swift) - reuse the FR numbers and glossary, copy same-language core code with its tests and an UPSTREAM record, write a platform mapping table, redo the UI in the platform's design language, and finish with a feature parity table. Use for "port to iOS/Android", "make an X version", "port this app", "build independent native versions for both platforms".
---

# Independent multi-platform implementation

Process: `<playbook>/process/11-cross-platform-port.md`. Templates: `templates/architecture-port.md`, `templates/dev-progress.md`, `templates/decisions.md`.

## Steps

1. **Read the source platform**: its FR doc, tech-spec / ARCHITECTURE, ADR index, CONTEXT / GLOSSARY and recent commits. The most complete platform defines the features; the platform written in the same language supplies the code.
2. **Create the new repo**: run `git init` and write `doc/architecture.md` (the platform mapping table is the heart of it), `doc/dev-progress.md` (suffix each task name with its FR-n), `doc/decisions.md` (make D-001 state which platform defines the features, which one the code is copied from, and what the UI is rebuilt to follow) and `CLAUDE.md`. Make the first commit.
3. **Scaffold and add check scripts**: see `process/05`; copy the tools from `tools/<platform>/`.
4. **Copy the core** (same language only): copy the source and its tests wholesale → format → get the tests passing unmodified on the new platform → record the source commit in `UPSTREAM.md` → commit. Only then add the features the new platform needs to the copy, with tests.
5. **Extract the app layer's pure logic**: strip UI dependencies from projection, selection, import preview, history checks, rule tables and similar code, and move it into the pure-logic module. Leave UI strings in the app layer so they can be localized.
6. **Implement task by task following `app-task-loop`**. Rebuild the UI in the new platform's design language instead of copying the other platform's controls.
7. **Handle platform gaps**: where the OS forbids something (background work, multicast, ARP), offer an alternative and document its limits. Where SDKs differ, use the currently recommended API and record how it differs from the other platform.
8. **Wrap-up**: write a feature parity table (per FR: same / substitute (reason) / not doing (reason)) into the decision log's wrap-up or the README.

## Rules

- Share requirements and rationale, not code frameworks. Don't introduce a cross-platform framework.
- Cross-repo dependency vs. copy: copy by default and record the upstream, so you never have to change the source platform's package definitions.
- Every deviation from the source platform needs a one-line reason in the platform mapping table or the decision log.

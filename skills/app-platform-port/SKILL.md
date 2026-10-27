---
name: app-platform-port
description: Build an independent native version of an existing app on another platform, sharing requirements but not code.
disable-model-invocation: true
---

# Independent multi-platform implementation

## Steps

1. **Read the source platform**: its FR doc, tech-spec / ARCHITECTURE, ADR index, `CONTEXT.md` and recent commits. The most complete platform defines the features; the platform written in the same language supplies the code.
2. **Create the new repo**: run `git init` and write `doc/architecture.md` using [ARCHITECTURE-FORMAT.md](ARCHITECTURE-FORMAT.md). The platform mapping table is the heart of it.
3. **Scaffold and add check scripts**: Call the Skill tool with "app-scaffold". Suffix each task name with its FR-n. Make D-001 state which platform defines the features, which one the code is copied from, and what the UI is rebuilt to follow.
4. **Copy the core** (same language only): copy the source and its tests wholesale → format → get the tests passing unmodified on the new platform → record the source commit in `UPSTREAM.md` → commit. Only then add the features the new platform needs to the copy, with tests.
5. **Extract the app layer's pure logic**: strip UI dependencies from projection, selection, import preview, history checks, rule tables and similar code, and move it into the pure-logic module. Leave UI strings in the app layer so they can be localized.
6. **Implement task by task**: Call the Skill tool with "app-task-loop". Rebuild the UI in the new platform's design language instead of copying the other platform's controls.
7. **Handle platform gaps**: where the OS forbids something (background work, multicast, exact alarms), offer an alternative and document its limits. Where SDKs differ, use the currently recommended API and record how it differs from the other platform.

## Rules

- Share requirements and rationale, not code frameworks. Don't introduce a cross-platform framework.
- Cross-repo dependency vs. copy: copy by default and record the upstream, so you never have to change the source platform's package definitions.
- Every deviation from the source platform needs a one-line reason in the platform mapping table or the decision log.

## Done when

A feature parity table exists, one row per FR, each marked "same", "substitute (reason)" or "not doing (reason)", in the decision log's wrap-up or the README. In your reply to the user, list every "substitute" and "not doing" row.

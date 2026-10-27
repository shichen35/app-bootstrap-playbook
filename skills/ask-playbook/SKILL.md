---
name: ask-playbook
description: Ask which playbook skill or phase fits where your app is now, from idea to release. A router over this repo's skills.
disable-model-invocation: true
---

# Ask Playbook

This is a map, not an executor. Based on where the user is now, point to the skill for the next step and explain how to carry context between phases, then stop and let the user invoke it. Don't run the whole pipeline for them.

## Main flow

| # | Phase | Output | Use |
|---|---|---|---|
| 1 | Align on the idea | One-sentence idea, target users and what they use today, platforms and minimum OS, monetization intent, red lines | `/grilling` |
| 2 | Research | `doc/competitors/*.md`, `doc/competitor-analysis.md`, `doc/pricing-research.md` | `/app-research` |
| 3 | Requirements, architecture, mock | `doc/feature-requirements.md` (FR-n), `CONTEXT.md`, `doc/tech-spec.md`, `doc/adr/`, `doc/mock/ui-mock.html` | `/app-spec` |
| 4 | Scaffold | A buildable empty project, `CLAUDE.md`, `tools/check.sh`, `doc/dev-progress.md`, `doc/decisions.md` | `/app-scaffold` |
| 5 | Implementation | One commit per task, screenshot self-review at milestones | `/app-task-loop` (milestones call `/app-screenshot-review` and `/code-review`) |
| 6 | Release | Private repo, CI, Dependabot, release checklist | `/app-repo-publish` |

## Other entry points

- You already have one platform and want another: `/app-platform-port`.
- Only need a competitor comparison or pricing: `/app-research`.
- Resuming after a session limit: `/app-task-loop`, which continues from the first unticked task in `doc/dev-progress.md`.
- UI polish only: `/app-screenshot-review`.
- A bug, a failing test, a slowdown: `/diagnosing-bugs`.
- Reviewing a change: `/code-review`.

## Context between phases

| Boundary | How | Why |
|---|---|---|
| Align → research → requirements and architecture | Same session | Each phase builds on the previous phase's discussion |
| Architecture → scaffold | Clearing context is fine | Every conclusion is already written into `doc/` |
| Verifying each competitor | Subagent | You only need the dossier it hands back |
| Between tasks | Same session; compact it when it gets long, or start a new session | State lives in `doc/dev-progress.md` and `doc/decisions.md` and can be restored at any time |
| Long unattended runs | Set a scheduled wake-up at the start of `/app-task-loop` | It resumes on its own after an interruption |

## Decisions only a human can make

- Choosing an ADR option, the boundary between Free and Pro, pricing.
- Downloading large files, creating a remote repo, pushing, rewriting pushed history, any purchase.

## Dependencies

`grilling`, `domain-modeling`, `tdd`, `code-review` and `diagnosing-bugs` come from [mattpocock/skills](https://github.com/mattpocock/skills). If they aren't installed, each skill in this repo describes a simpler fallback.

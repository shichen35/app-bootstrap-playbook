---
name: app-bootstrap
description: Bootstrap a new app from an idea to a release-ready, tested, documented native app (Android Kotlin/Compose, iOS SwiftUI, macOS Swift) following this playbook - research, numbered requirements, architecture and ADRs, HTML mock, scaffold with a check script, one-commit-per-task implementation, simulator screenshot review, monetization, cross-platform port, GitHub. Use when the user says "build an app from an idea", "bootstrap a project", "follow the playbook", "new project", or asks to plan and build a whole app end to end.
---

# App Bootstrap (orchestrator)

`<playbook>` is the playbook root (two levels above this file: `skills/<name>/SKILL.md` → `../../`). The full process lives in `<playbook>`. Read `process/00-overview.md` before you start, read the matching `process/NN-*.md` as you enter each phase, and copy output docs from `templates/`.

## Step 1: Confirm the inputs (ask for anything missing, all in one message)

1. The idea in one sentence + target users + what they use today.
2. Platforms (Android / iOS / macOS), minimum OS, and whether an existing version on another platform can serve as reference (path).
3. Monetization intent (free / one-time purchase / subscription / ads) and red lines (what the app must never do).
4. Whether to set a scheduled wake-up to resume after interruptions (on by default for long runs).

## Phases and the skill for each

| Phase | What | Use |
|---|---|---|
| 1 Research | Competitor dossiers + comparison + pricing | `app-competitor-research` |
| 2 Requirements | `doc/feature-requirements.md` (FR-n), `CONTEXT.md` | `app-spec` |
| 3 Architecture | `doc/tech-spec.md`, `doc/adr/`, `performance-research.md` | `app-spec` |
| 4 Mock | `doc/mock/ui-mock.html`, a single-file HTML mock covering narrow / wide / short windows | This skill (see process/04) |
| 5 Scaffold | A buildable empty project, `CLAUDE.md`, `tools/check.sh`, `dev-progress.md`, `decisions.md` | This skill + the scripts in `tools/` |
| 6–10 Implementation | Work through the task list, one commit per task, screenshot self-review at milestones | `app-task-loop`, `app-screenshot-review` |
| 11 Multi-platform | Independent implementation on the other platform | `app-platform-port` |
| 12 Release | Private repo, Dependabot / CI, README, release checklist | `app-repo-publish` |

## Gates (self-check before each phase ends; don't move on until it passes)

- Research: every comparison cell has evidence and an evidence strength; the conclusions state who we don't compete with, and on what.
- Requirements: every FR is testable and has numeric bounds; there is a "Not doing, and why" section.
- Architecture: the layering direction is clear; the pure-logic layer's boundary is written as a red line; key trade-offs have ADRs (including the rejected options).
- Scaffold: `tools/check.sh` exits 0 on the empty project.
- Implementation: every commit passes the check, the task list is ticked in step, and the decision log is updated.
- Wrap-up: the decision log lists what needs a human decision, what wasn't done, and what was not verified.

## Needs a human decision / authorization (stop and ask)

- Choosing an ADR option, the Pro boundary, pricing.
- Downloading large files (simulator runtimes, SDKs), creating a remote repo, pushing, rewriting pushed history, any purchase.

## Output style

- Write docs in the user's language unless they ask otherwise; code comments are in English and only say why.
- Commits: one-line Conventional Commit, no body, no attribution.
- When replying to the user: results and not-verified items first, then links.

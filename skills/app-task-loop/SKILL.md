---
name: app-task-loop
description: Implement an app task by task from doc/dev-progress.md - one task per single-line Conventional Commit, tools/check.sh (lint, tests, build, localization) must exit 0 before every commit, decisions and problems logged in doc/decisions.md, milestones reviewed with simulator screenshots, and a recurring wake-up so the work resumes after a session limit. Use for "work through the task list", "continue development", "resume", "one commit per task", or phases 5-10 of app-bootstrap.
---

# Task loop

Process: `<playbook>/process/05-scaffold-and-guardrails.md`, `06-implementation-loop.md`, `07-testing-and-verification.md`.

## Before you start

1. Read `CLAUDE.md`, `doc/dev-progress.md`, the end of `doc/decisions.md`, `git log --oneline | head` and `git status`.
2. If there are uncommitted changes, work out which task they belong to, finish it, get it through the checks, and commit.
3. For long runs, set a recurring wake-up with CronCreate (e.g. `17 */3 * * *`) using the prompt in `<playbook>/prompts/resume.md`. Tell the user it expires after 7 days and only lasts for this session. CronDelete it once everything is done.

## Each task

```text
1. Read the task line and the FRs / ADRs it cites
2. Implement: pure logic goes in the core module, with tests written first or alongside; keep the platform layer thin
3. New UI strings: write both English and Simplified Chinese (iOS: after building, tools/sync-strings.sh + tools/translate.py; Android: each language's strings.xml)
4. tools/check.sh > log 2>&1; echo $?   # must be 0; never judge by "| tail -1 &&"
5. Milestone (★): call app-screenshot-review
6. Decision → D-n in decisions.md; problem → P-n; lasting trade-off → new ADR
7. Tick this line in dev-progress
8. git add -A && git commit -m "type(scope): subject"   # one line, no body, no trailer, no attribution
```

## Rules

- One task, one commit, and the commit includes the code, tests, translations, the tick and the decision-log entry together.
- Never skip a failing check. Reproduce intermittent failures and log them (P-n); don't pretend you didn't see them.
- Never let two agents write the same set of files at once; read-only research can run in parallel subagents.
- Stop and ask before external actions that need the user's authorization (downloading large files, pushing, purchases).
- Write any verification you can't do (it needs tapping, a real device, a real purchase) into the decision log as "not verified"; don't pretend it's done.

## Wrap-up

Once everything is ticked: README, final screenshots, the "Wrap-up" section of the decision log (what needs a human decision, what wasn't done, what was not verified), and a final `docs: …` commit. Reply to the user with the results, the not-verified items and a link to the decision log.

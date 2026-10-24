# 06 · Incremental build: task list, one commit per task, resume after an interruption

Goal: break the requirements into 15–35 tasks that can each be committed on their own, and have the agent work through the list one task at a time. Whenever work is interrupted (a session limit, a new session, a hand-off to someone else), it can pick up again from the state of the repo.

## Task list `doc/dev-progress.md` (template [templates/dev-progress.md](../templates/dev-progress.md))

- Open with a **resume protocol**: "After an interruption, continue from the first unchecked task: check `git log --oneline` and `git status` first; finish any uncommitted changes, pass the checks, then commit."
- One line per task: `- [ ] N. type(scope): description (FR-n)`, with ★ on milestones.
- Order: docs → scaffold → pure logic (entry model → dates and recurrence → Migration rules → import/export) → platform implementation (storage / reminders) → command entry point → main screen ★ → add → actions → detail ★ → settings → reminders → export → background → wide screen ★ → widgets → extra features → monetization ★ → Wrap-up ★.
- Work added later goes into a "To be scheduled" section and moves into the numbered list when it's scheduled.

## The loop for each task

```text
Read the task and its related FRs / ADRs
  → write the code (tests first for pure logic)
  → tools/check.sh passes (lint, tests, build, localization)
  → at milestones: take simulator screenshots, read them, fix the problems
  → log new decisions / problems in doc/decisions.md (D-n / P-n)
  → check off the item in dev-progress
  → git commit -m "type(scope): subject"   # one line, one commit per task
```

Commit messages: Conventional Commits, one line, no body, no trailers, no attribution. The subject is a verb phrase describing the user-visible effect (`feat(log): roll unfinished tasks into the next month on migration`).

## Decision log `doc/decisions.md` (template [templates/decisions.md](../templates/decisions.md))

- **D-n decisions**: what was chosen, why, and what was given up.
- **P-n problems**: symptom, cause, and how it was solved (or why it wasn't).
- **Milestone Mn**: screenshot file names, what was observed, what self-review fixed, and what was **not verified**.
- The final "Wrap-up" section: what needs human review or a decision, what wasn't done and why, and what was not verified.

How ADRs and the decision log divide the work: ADRs record long-lived, architecture-level trade-offs that need a human decision; the decision log is the running record of every decision, large or small, and every problem hit during implementation. The iOS version used only the decision log (the user asked for a single file); the Android version has both.

## Long jobs: scheduled wake-up and resume

- When work starts, set up a **recurring in-session task** (Claude Code `CronCreate`, say every 3 hours) whose prompt spells out: "Read dev-progress and git status; if anything is unfinished, continue from the first unchecked task, following the rules in CLAUDE.md." After a session limit interrupts the work, it wakes the session once quota is back. Recurring tasks expire automatically after 7 days; delete it yourself once everything is done.
- For the prompt template, see [prompts/resume.md](../prompts/resume.md).

## Parallelism and sub-agents

- Use parallel sub-agents for **read-only, independent** work such as research and fact-checking.
- Coding tasks run sequentially in the main session: never have two agents edit the same files at once.
- Every sub-agent brief must stand on its own: goal, files, "Done when" criteria, and directions already ruled out.

## Gate (per task)

- [ ] `tools/check.sh` exits 0 (don't judge by piping it and reading the last line).
- [ ] New logic has tests (in the pure-logic module).
- [ ] Every new user-facing string is translated.
- [ ] The dev-progress checkbox and decision log updates go in the same commit as the code.

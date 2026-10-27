# 06 · Incremental build: task list, one commit per task, resume after an interruption

Goal: break the requirements into 15–35 tasks that can each be committed on their own, and have the agent work through the list one task at a time. Whenever work is interrupted (a session limit, a new session, a hand-off to someone else), it can pick up again from the state of the repo.

For the how-to, see the [app-task-loop](../skills/app-task-loop/SKILL.md) Skill; the formats for the task list and decision log are in the [app-scaffold](../skills/app-scaffold/SKILL.md) directory.

## Why one commit per task

Resuming depends on two facts: the last commit and the first unchecked task. With exactly one commit per task, and the checkbox committed together with the code, the repo itself shows how far the work got. Rollbacks and reviews happen per task too.

## Task order

An order that has worked in practice: docs → scaffold → pure logic (entry model → dates and recurrence → Migration rules → import/export) → platform implementation (storage / reminders) → command entry point → main screen ★ → add → actions → detail ★ → settings → reminders → export → background → wide screen ★ → widgets → extra features → monetization ★ → Wrap-up ★.

Pure logic comes first because it has no UI dependency and the fastest tests, and every later UI task builds on it. A ★ milestone comes every 3–5 tasks or so, and that's where the screenshot reviews happen.

## Commit messages

Conventional Commits, one line, no body, no trailers, no attribution. The subject is a verb phrase describing the user-visible effect, such as `feat(log): roll unfinished tasks into the next month on migration`, not `update MigrationRule.kt`.

## How ADRs and the decision log divide the work

ADRs record long-lived, architecture-level trade-offs that need a human decision. The decision log (D-n / P-n) is the running record of every decision, large or small, and every problem hit during implementation. Its final "Wrap-up" section lists what needs a human decision, what wasn't done, and what was not verified. If the user asks for all decisions in a single file, use the decision log alone.

## Why a scheduled wake-up

Long jobs will hit the session limit. A recurring in-session task (say, every 3 hours) wakes the session once quota is back and continues from the task list, so nobody has to babysit it. Recurring tasks expire automatically after 7 days; delete them yourself once everything is done. When the playbook is installed as a plugin, every new session also opens by reporting which task is next.

## Parallelism

Read-only, independent work such as research and fact-checking is a good fit for parallel sub-agents. Code gets written sequentially in the main session: two agents editing the same files at once create more conflicts than they save time.

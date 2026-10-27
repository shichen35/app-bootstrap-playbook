## What it does

Works through `doc/dev-progress.md` one task at a time: implement, run the check, log decisions, tick the task, commit. Each task is exactly one single-line commit. At milestones (★) it also runs a screenshot review and a code review. For long runs it sets a scheduled wake-up, so it can resume on its own after a session limit cuts it off.

## When to reach for it

Type `/app-task-loop`, or let the agent pick it up when you say "keep building" or "work through the list". Once on, it stays on for the rest of the session until you say "stop the task loop".

## Prerequisites

The project needs `tools/check.sh` and `doc/dev-progress.md`. If either is missing, it calls `app-scaffold` first.

## Common questions

**Why was my commit blocked?**
With the plugin installed, the pre-commit hook checks whether `tools/check.sh` has passed since the last code change. Run the check and commit again. If you changed only Markdown (ticking a task, writing the decision log), you do not need to rerun it.

**The check fails intermittently, but I'm sure the code is fine?**
Reproduce it first, then log it as P-n. Do not skip it: the flaky failure you wave through today is often the bug you cannot pin down in the next task.

**How do I pick up after an interruption?**
With the plugin installed, every new session opens by telling you which item is the next task. Without the plugin, type `/app-task-loop`: it checks `git status` first, finishes any uncommitted work, then carries on.

## It's working if

- `git log --oneline` shows one line per task, matching the task list one to one.
- The "not verified" section of the decision log is accurate: everything it lists is something you really need to verify yourself.
- After several interruptions, the task list and the code still match.

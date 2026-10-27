---
name: app-task-loop
description: Implement an app task by task from doc/dev-progress.md - one task per single-line Conventional Commit, tools/check.sh (lint, tests, build, localization) must exit 0 before every commit, decisions and problems logged in doc/decisions.md, milestones reviewed with screenshots and a code review, and a recurring wake-up so the work resumes after a session limit. Use for "work through the task list", "continue development", "resume", "one commit per task", "do the next task".
---

# Task loop

## Before you start

1. Read `CLAUDE.md`, `doc/dev-progress.md`, the end of `doc/decisions.md`, `git log --oneline | head` and `git status`. If `tools/check.sh` or `doc/dev-progress.md` is missing: Call the Skill tool with "app-scaffold".
2. If there are uncommitted changes, work out which task they belong to, finish it, get it through the checks, and commit.
3. For long runs, set a recurring wake-up with CronCreate (e.g. `17 */3 * * *`) using the prompt in [RESUME.md](RESUME.md). Tell the user it expires after 7 days and only lasts for this session. CronDelete it once everything is done.

## Each task

```text
1. Read the task line and the FRs / ADRs it cites
2. Implement: pure logic goes in the core module, tests first; keep the platform layer thin
3. New UI strings: write every language (iOS: after building, tools/sync-strings.sh + tools/translate.py; Android: each language's strings.xml)
4. tools/check.sh > /tmp/check.log 2>&1; echo $?   # must be 0; never judge by "| tail -1 &&"
5. Milestone (★): screenshot review + code review, see below
6. Decision → D-n in decisions.md; problem → P-n; lasting trade-off → new ADR (following the existing format in doc/adr/)
7. Tick this line in dev-progress
8. git add -A && git commit -m "type(scope): subject"   # one line, no body, no trailer, no attribution
```

When writing pure logic in step 2: Call the Skill tool with "tdd". Without that skill, write a failing test first, then implement until it passes.

Step 5 is two calls:

- Call the Skill tool with "app-screenshot-review".
- Call the Skill tool with "code-review", using the previous milestone's commit as the fixed point. Without that skill, read `git diff <previous milestone>..HEAD` yourself and check it against the Hard rules in CLAUDE.md and the FRs the tasks cite.

Fix what the reviews find in this milestone's commit, or log it as P-n and add it to the task list.

## Rules

**One task, one commit**, and the commit includes the code, tests, translations, the tick and the decision-log entry together.
Why: after an interruption, work resumes from "the last commit + the first unticked task". If one commit mixes two tasks, you can't tell which one is finished, and rollbacks and reviews have to take both at once.

**Check the exit code, not the last line of output.**
Why: a pipe swallows the failure code, so a failed check gets committed anyway. This has happened on a real project.

- Bad: `tools/check.sh | tail -1 && git commit -m "feat: …"`
- Good: `tools/check.sh > /tmp/check.log 2>&1; echo $?`, and only after you see `0`, run `git commit` as a separate step.

When this is installed as a plugin, a pre-commit hook blocks any commit if the checks haven't passed since the last code change. If it blocks you, run the checks; don't bypass the hook.

**Never skip a failing check.** Reproduce intermittent failures and log them (P-n); don't pretend you didn't see them.
Why: the flaky failure you skip today is the bug you can't pin down in the next task.

**If you can't verify something, write "not verified"; don't pretend it's done.**
Why: the user only checks what you list.

- Bad: "Purchase flow verified in the simulator." (nobody actually tapped through it)
- Good: "Purchase flow: a sandbox purchase needs a human to tap through it; not verified. Verified: the StoreKit configuration file loads and product prices display correctly."

**Other**

- Never let two agents write the same set of files at once; read-only research can run in parallel subagents.
- Stop and ask before external actions that need the user's authorization (downloading large files, pushing, purchases).

## Stays on

Once used, this skill stays on for the rest of the session. After answering other questions, a change of topic or context compaction, your next code change still gets committed under these rules. It ends in only two cases: the user says "stop the task loop" or "stop loop", or every task on the list is ticked.

## Done when

For each task: paste the `echo $?` output showing 0, then commit.

Once everything is ticked: README, final screenshots, the "Wrap-up" section of the decision log (what needs a human decision, what wasn't done, what was not verified), and a final `docs: …` commit. Reply to the user with the results, the not-verified items and a link to the decision log.

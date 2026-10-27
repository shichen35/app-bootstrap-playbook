## What it does

Sets up a buildable empty project with two guardrails in place: a `CLAUDE.md` that spells out the hard rules, and a `tools/check.sh` that must pass before every commit (lint, unit tests, build, translation completeness). It also generates the task list `doc/dev-progress.md` and the decision log `doc/decisions.md`. From here on, quality depends on these two guardrails, not on the agent's memory.

## When to reach for it

Type `/app-scaffold`, or let the agent pick it up once the spec is final and it is ready to start building. `app-platform-port` also calls it when porting to another platform.

## Prerequisites

`doc/feature-requirements.md` and `doc/tech-spec.md` must exist. The iOS and Android check and screenshot scripts live in this skill's `scripts/` directory, and it copies them into the project's `tools/`.

## Common questions

**The iOS build passes, so why does the check report missing translations?**
Unlike Xcode, `xcodebuild` does not sync new strings into `.xcstrings`, so the check script syncs them itself before checking. Without that step, missing translations go unnoticed.

**What does `check-stamp.sh` do?**
When `check.sh` passes, it records a fingerprint of the code at that point. The pre-commit hook uses that fingerprint to tell whether the check has run again since the last code change.

## It's working if

- `tools/check.sh` exits 0 on the empty project, and the first commit is `build: …`.
- A new session knows the commit format and the hard rules without you reminding it.

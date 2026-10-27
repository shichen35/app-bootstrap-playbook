# 05 · Scaffold and guardrails: project, CLAUDE.md, check script

Goal: the very first code commit installs both the rules the agent follows every session and the checks every commit must pass. From then on, quality rests on those two things, not on anyone's memory.

For the how-to, see the [app-scaffold](../skills/app-scaffold/SKILL.md) Skill; the scripts are in its `scripts/` directory.

## Why the guardrails go in the first commit

Agents forget, get interrupted and switch sessions. Hard rules in `CLAUDE.md` get read at the start of every session; checks in `tools/check.sh` run on every commit. Install both in the first commit and every later task runs under the same constraints, with nothing riding on what anyone remembers.

Most hard rules in `CLAUDE.md` come from the ADRs' red lines: the ADR explains the why, and `CLAUDE.md` keeps a one-line rule.

## Why the checks cover localization

A missing translation breaks neither the build nor the tests. It only shows up as stray English once a user switches to Chinese. Add "every key has a translation" to the check script, and a missing translation gets blocked before commit just like a compile error.

## Why a commit gate

A rule that says "run the checks before committing" isn't enough: we've had a pipe swallow a failing exit code. When the playbook is installed as a plugin, a pre-commit hook confirms the checks have passed since the last code change (using the fingerprint `check-stamp.sh` records), which turns the rule into a mechanical check.

## Lessons

- Unlike the Xcode IDE, `xcodebuild` doesn't sync strings into `.xcstrings`. Run `xcstringstool sync` yourself, or missing translations go unnoticed.
- Pipes swallow exit codes: `tools/check.sh | tail -1 && git commit` commits even when the checks fail. Either `set -o pipefail`, or write the output to a file first and then check the exit code.
- Without a shared scheme, xcodebuild generates one automatically and prints "Supported platforms … is empty". That's noise.

# App Bootstrap Playbook

A complete, reusable process for taking an app from idea to store-ready, with an independent native build on each platform, driven by an AI coding agent. It comes from a real project built independently for macOS, Android and iOS: all three shared one set of requirement numbers, and every step was backed by docs, decision records, per-commit checks and simulator screenshot self-review. One fictional example runs through all the docs: **the Example App** (a bullet journal app), with rapid-logging symbols, a Daily / Monthly / Future Log, Migration, Collections and an Index.

## What's here

| Directory | Contents | When to use it |
|---|---|---|
| [process/](process/) | 14 process docs, one per stage: what to do, what it produces, how to accept it, lessons learned | Read [00-overview](process/00-overview.md) before starting a new project; read each stage's doc when you reach that stage |
| [templates/](templates/) | Templates for each stage's output docs: requirements, architecture, ADR, task list, decision log, competitors, pricing, performance, UI review, CLAUDE.md, release checklist | Copy into the new project's `doc/` and fill in |
| [skills/](skills/) | 7 Claude Code skills (`SKILL.md`) that turn the process into instructions an agent can run directly | Symlink into `~/.claude/skills/` |
| [prompts/](prompts/) | Paste-ready prompts for every stage, plus prompts for resuming after an interruption, porting, review and publishing | Copy into your conversation with the agent |
| [tools/](tools/) | Reusable scripts: iOS / Android check scripts, String Catalog sync and Chinese-string check, simulator screenshots, app icon generation, commit date cleanup | Copy into the new project's `tools/` and rename as needed |

## Start a new project in three steps

1. Install the skills (once):

   ```bash
   # Run from the root of this repo
   for d in "$PWD"/skills/*/; do ln -sfn "$d" ~/.claude/skills/$(basename "$d"); done
   ```

2. Create a project directory, write up your idea in the format of [prompts/00-kickoff.md](prompts/00-kickoff.md), and hand it to the agent. It follows the `app-bootstrap` skill through each stage in turn: research → requirements → architecture → mock → scaffold → step-by-step implementation → self-review → publish.

3. At the end of each stage, check the output against the "stage gates" in [process/00-overview.md](process/00-overview.md) before moving on. For long tasks, have the agent set a scheduled wake-up at the start ([prompts/resume.md](prompts/resume.md)), so work resumes on its own if a session limit cuts it off.

## Core principles (one page)

1. **Docs first, one numbering scheme throughout**: requirements are numbered FR-n, and commits, ADRs, the decision log and every platform's implementation cite the same numbers.
2. **Write decisions down**: every "why this way / why not that way" goes into an ADR (≤ 40 lines, four sections) or the decision log (D-n / P-n). When the agent is interrupted, someone new takes over, or work moves to another platform, the docs restore the context.
3. **Keep pure logic apart from the platform**: the engine and business rules live in modules with no UI dependency (Kotlin `core/`, a Swift Package), with unit tests that run in seconds on a dev machine. The platform layer is thin glue.
4. **One task, one commit**: a single-line Conventional Commit. `tools/check.sh` (lint + tests + build + localization completeness) must pass before every commit, and the same commit ticks off the task list.
5. **Review your own screenshots**: at each milestone, the agent takes screenshots in the iOS Simulator / Android Emulator, reads them to find problems, fixes them before committing, and writes its findings into the decision log.
6. **Window-only, never device**: layout adapts to the window's width and height (Android window size, iOS size class), not to the device model.
7. **Monetization has red lines**: the Free / Pro boundary, ad placement and downgrade rules are written as ADRs. A downgrade never changes user data, never interrupts running work, and there are no scheduled upsell prompts.
8. **Build each platform independently; share requirements, not code**: in the same language you may copy core code (recording the upstream commit); across languages, share only the FRs and test-case ideas.
9. **Be honest about what is not verified**: anything the agent cannot check (it needs taps, a real device or a real purchase) is listed explicitly and handed to a human for acceptance.

## Trademarks

Android, Google Play, AdMob, iOS, iPadOS, macOS, Xcode, SwiftUI, App Store, StoreKit, GitHub, Claude Code and other names mentioned here are trademarks of their respective owners. They are used only to describe how the corresponding platforms and tools are used technically. This project is not affiliated with or endorsed by those owners.

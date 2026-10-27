# App Bootstrap Playbook

A complete, reusable process for taking an app from idea to store-ready, with an independent native build on each platform, driven by an AI coding agent. It comes from a real project built independently for macOS, Android and iOS: all three shared one set of requirement numbers, and every step was backed by docs, decision records, per-commit checks and simulator screenshot self-review. One fictional example runs through all the docs: **the Example App** (a bullet journal app), with rapid-logging symbols, a Daily / Monthly / Future Log, Migration, Collections and an Index.

## What's here

| Directory | Contents | When to use it |
|---|---|---|
| [process/](process/) | 14 background docs, one per stage: why it works this way, examples, lessons learned. The skills are the source of truth for the actual steps and completion criteria | Read [00-overview](process/00-overview.md) before starting a new project; read each stage's doc when you reach that stage |
| [skills/](skills/) | 8 skills that turn the process into instructions an agent can run directly. Each stage's output formats (`*-FORMAT.md`) and scripts live in the directory of the skill that uses them | Install as a plugin, or symlink into `~/.claude/skills/` |
| [docs/](docs/) | One page per skill: what it does, when to reach for it, common questions, and how to tell it's working | When you are deciding whether a skill fits |
| [hooks/](hooks/) | Plugin hooks: block `git commit` when code has changed and `tools/check.sh` has not passed since; report task list progress when a session starts | Active automatically when installed as a plugin |
| [prompts/](prompts/) | Paste-ready prompts for every stage, plus prompts for resuming after an interruption, porting, review and publishing | Copy into your conversation with the agent |

## Start a new project in three steps

1. Install the skills (once), in one of two ways:

   ```bash
   # Install as a Claude Code plugin (run from the root of this repo)
   claude plugin marketplace add shichen35/app-bootstrap-playbook   # or the local path to this repo
   claude plugin install app-bootstrap-playbook@app-bootstrap-playbook
   ```

   ```bash
   # Or symlink into ~/.claude/skills and ~/.agents/skills; git pull keeps them current
   scripts/link-skills.sh
   ```

   Some steps call `grilling`, `domain-modeling`, `tdd`, `code-review` and `diagnosing-bugs` from [mattpocock/skills](https://github.com/mattpocock/skills). Install those too; without them, each skill falls back to a simpler approach.

2. Create a project directory, write up your idea in the format of [prompts/00-kickoff.md](prompts/00-kickoff.md), and hand it to the agent with `/app-research` at the start. Whenever you are unsure which skill a stage needs, ask `/ask-playbook`.

3. At the end of each stage, check the output against the "Done when" list at the end of the matching skill before moving on. For long tasks, `app-task-loop` sets a scheduled wake-up at the start, so work resumes on its own if a session limit cuts it off. With the plugin installed, two hooks act as a safety net: each new session opens with a report of the next task, and every commit first confirms the check has passed. The hooks need `jq` (bundled with macOS 15 and later) and do not run with a symlink install.

## Skills

**User-invoked** (only a human can trigger these by typing `/name`: they cost money, act outside the repo, or make a large one-off change)

| Skill | What it does |
|---|---|
| [ask-playbook](skills/ask-playbook/SKILL.md) | Router: which stage you are in, which skill comes next, how to handle context between stages |
| [app-research](skills/app-research/SKILL.md) | Parallel subagents verify about 5 competitors, then synthesize a comparison and pricing research |
| [app-platform-port](skills/app-platform-port/SKILL.md) | Build independently on another platform, sharing requirements but not code |
| [app-repo-publish](skills/app-repo-publish/SKILL.md) | Redaction check, private repo creation and push, CI, release checklist |

**Model-invoked** (the agent uses these on its own when they fit; you can also invoke them directly)

| Skill | What it does |
|---|---|
| [app-spec](skills/app-spec/SKILL.md) | FR requirements, glossary, tech-spec, ADRs, performance research, HTML mock |
| [app-scaffold](skills/app-scaffold/SKILL.md) | A buildable empty project, CLAUDE.md, `tools/check.sh`, task list, decision log; ships iOS / Android scripts |
| [app-task-loop](skills/app-task-loop/SKILL.md) | One task per commit, a passing check before every commit, screenshot and code review at milestones, scheduled resume |
| [app-screenshot-review](skills/app-screenshot-review/SKILL.md) | Take screenshots, review them against a checklist, fix, record the milestone |

Maintenance conventions are in [AGENTS.md](AGENTS.md); what this repo accepts and rejects is in [SCOPE.md](SCOPE.md).

Conventions: when one skill calls another, it says `Call the Skill tool with "<name>"` instead of linking files across directories, and format files and scripts live only in the directory of the skill that owns them. User-invoked skills may call model-invoked ones, never the reverse.

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

## License

[MIT](LICENSE).

## Trademarks

Android, Google Play, AdMob, iOS, iPadOS, macOS, Xcode, SwiftUI, App Store, StoreKit, GitHub, Claude Code and other names mentioned here are trademarks of their respective owners. They are used only to describe how the corresponding platforms and tools are used technically. This project is not affiliated with or endorsed by those owners.

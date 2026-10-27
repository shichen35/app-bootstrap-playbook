# AGENTS.md

This repo is a set of skills (plus two hooks) that take a native app from idea to store release. This file is for the agents and people who maintain it.

## Repo map

| Path | What it is |
|---|---|
| `skills/<name>/SKILL.md` | The skill itself. Format files (`*-FORMAT.md`) and scripts (`scripts/`) live in the directory of the skill that uses them, with no copies anywhere else |
| `skills/<name>/agents/openai.yaml` | Codex display name and invocation policy; keep in sync with the `SKILL.md` frontmatter |
| `docs/<name>.md` | Human-facing page: what it does, when to reach for it, common questions, it's working if. Not a copy of `SKILL.md` |
| `hooks/` | Plugin hooks: the pre-commit check gate and the task progress report at session start |
| `tests/hooks.test.sh` | Tests that run the hooks against throwaway repos |
| `process/` | Long-form background: the history and pitfalls of each stage. The skills are the source of truth for rules |
| `prompts/` | Prompts you can paste straight into an agent |
| `.claude-plugin/` | Plugin and marketplace manifests |
| `scripts/link-skills.sh` | Symlinks the skills into this machine's skills directories |

## Conventions

- **Invocation**:
  - User-invoked: `SKILL.md` sets `disable-model-invocation: true`, `openai.yaml` sets `policy.allow_implicit_invocation: false`, and the description is one sentence for humans.
  - Model-invoked: set neither, and list trigger phrases in the description.
  - How to choose: ask whether the agent gains anything by reaching for it on its own. Anything that costs money, acts outside the repo, or makes a large one-off change is user-invoked.
- **Skills calling skills**: write `Call the Skill tool with "<name>"`, one call at a time. Never use cross-directory links such as `../other-skill/FILE.md`. No skill may call a user-invoked skill; instead, write "tell the user to type `/<name>`".
- **External dependencies**: whenever a skill calls one from mattpocock/skills, follow it immediately with one sentence on what to do if that skill is not installed.
- **Done when**: every skill ends with concrete evidence of done (pasted command output, a file list), never "self-check passed".
- **Writing rules**: state the rule, then why. For rules that are easy to get wrong, add a Bad / Good pair.
- **Length**: keep `SKILL.md` under 100 lines. Move platform details and formats into files in the same directory that are read only when needed.

## Keep in sync when changing

When you add, remove or rename a skill, or change its behavior, update all of these in the same commit:

1. The `skills` list in `.claude-plugin/plugin.json`.
2. The router table in `skills/ask-playbook/SKILL.md`.
3. The Skills table in `README.md`.
4. `docs/<name>.md`.
5. `agents/openai.yaml`.

If you change a hook or `check-stamp.sh`, run `tests/hooks.test.sh`.

Before committing, run:

```bash
claude plugin validate . --strict
claude plugin validate .claude-plugin/plugin.json --strict
tests/hooks.test.sh
```

Commit messages: a single-line Conventional Commit, with no body and no attribution.

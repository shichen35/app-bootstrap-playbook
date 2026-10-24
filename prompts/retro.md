Distill the whole {{project}} workflow (idea, requirements analysis, architecture design, tech-spec, step-by-step implementation, lint and tests, performance analysis and optimization, UI screenshots, UI polish, independent multi-platform builds, GitHub integration) into reusable process docs, spec docs (templates), skill docs, prompt docs and scripts under {{new directory}}, so future projects can bootstrap from them.

Sources: {{each repo's doc/, CLAUDE.md, tools/, git log, decision log}}. Requirements:
- One process doc per stage: inputs, steps, outputs, gate, lessons.
- Templates with project details stripped out, using {{placeholders}}.
- Skills written as installable SKILL.md files (the frontmatter description spells out trigger phrases).
- Prompts organized by stage, ready to paste.
- Scripts made project-agnostic, with the project name as a parameter.
- A final doc that collects the lessons learned.

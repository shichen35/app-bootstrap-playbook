## What it does

Tells you where you are on the path from idea to store release, which skill to use next, and whether to clear context between stages. It only points the way and then stops; it never runs the whole process for you.

## When to reach for it

Only you can trigger it, by typing `/ask-playbook`; the agent never calls it on its own. Use it when you start a project, when you come back after a few days away, or when you are not sure which skill fits a task.

## Common questions

**Why doesn't it just run the whole process for me?**
Every stage ends with decisions that are yours to make: which ADR option to take, where to draw the Pro line, whether to push. An "orchestrator" skill would make those calls on its way through. The router only points the way and leaves the decisions to you.

**`grilling`, `code-review` and the others aren't in this repo?**
Correct. They come from [mattpocock/skills](https://github.com/mattpocock/skills), and this repo's skills call them. Without them, each skill falls back to a simpler approach that works less well.

## It's working if

- You rarely need to ask "what's next?"
- Every time you clear context, the agent picks up from `doc/` without you having to explain everything again.

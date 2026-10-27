## What it does

Picks about 5 competitors and sends one subagent to verify each against the same checklist, then synthesizes a feature and UI comparison, an overlap and differentiation analysis, and pricing research. Every conclusion must trace back to evidence on a store page, official site or screenshot, labeled with its evidence strength.

## When to reach for it

Only you can trigger it, by typing `/app-research`: it runs several subagents in parallel and is not cheap. Use it once you have an idea but before you write requirements. You can also use it for a standalone pricing research pass.

## Common questions

**Does "Not mentioned" mean the competitor lacks the feature?**
No. A feature missing from a store page may simply be undocumented. Only "No" (backed by evidence that the feature is absent) can be used in a marketing comparison.

**What happens with the research findings?**
Gaps that bear directly on positioning become candidate requirements, and you decide which go into `doc/feature-requirements.md`. Research that cannot change the requirements is wasted effort.

## It's working if

- Every cell in the comparison table links back to a dossier, where you can find the original source.
- The conclusions say where we will not compete and with whom, rather than only listing strengths.
- At least one requirement was added or cut because of the research.

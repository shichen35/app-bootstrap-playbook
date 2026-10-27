## What it does

Builds the same app again, independently, on another platform. The platforms share requirement numbers and the glossary, not a code framework. Core code in the same language is copied whole, tests included, with the upstream commit hash recorded; the UI is rebuilt in the new platform's design language. It finishes with a feature parity table.

## When to reach for it

Only you can trigger it, by typing `/app-platform-port`: a port touches an entire new repo. Use it when one platform is done and you want to build the next.

## Common questions

**Why not use a cross-platform framework and share one codebase?**
Each platform needs its own native experience, and platform capabilities (widgets, background work, notifications) differ widely. Sharing requirements and test ideas pays off more than sharing a code framework.

**Why copy same-language core code instead of making it a shared dependency?**
A copy with its upstream commit hash recorded lets each platform evolve on its own, so a change for one platform never forces an edit to the other's package definition.

## It's working if

- Every "substitute" and "not doing" entry in the feature parity table states a reason.
- The new platform's tests were copied unchanged from the source platform, and they pass.

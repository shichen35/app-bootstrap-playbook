# 02 · Requirements: FR numbers, platform mapping, glossary

Goal: one set of feature requirements **shared by every platform**, each item numbered and testable, which the architecture, tasks, commits and ADRs all reference.

For the how-to, see the [app-spec](../skills/app-spec/SKILL.md) Skill and its [FR-FORMAT.md](../skills/app-spec/FR-FORMAT.md).

## Why number them

FR-n is the anchor that ties all the documents together: tasks in the task list carry an FR-n, commits and ADRs cite it, and the other platform's platform mapping table maps against it line by line. Numbers are only ever appended, never renumbered, so an FR-7.3 cited in a commit three months ago still points to the same requirement today.

## Platform mapping table

When porting or going multi-platform, give each mechanism of the original its own row: what it maps to on this platform, and why. Example:

| Android | iOS | Notes |
|---|---|---|
| AlarmManager reminders | Local notifications | iOS caps pending notifications at 64, so only the nearest batch is scheduled |
| Receiving text shared from other apps | Covered by "Open in App" for now | A Share Extension is expensive; deferred |

## Why "Not doing, and why" is mandatory

This section keeps the agent from adding features on its own initiative, and keeps future contributors from reopening ideas that were already rejected. The Example App explicitly rules out social sharing, multi-user collaboration, cloud AI summaries and a web version.

## Glossary

The glossary keeps code names, UI copy and docs on one vocabulary, and gives every platform the same English terms. Example:

> **Migration**: moving an unfinished task to the next month or into the Future Log. The original entry is marked `>`, not deleted. _Avoid_: Move, Copy.

## Lessons

- The agent builds a detail like "the user must explicitly check 'Add valid items only' before the preview" only if the requirements say so. Leave it out and it gets simplified away.
- A Free-tier rule like "limits are checked only at creation and never lock existing content retroactively" beats "make anything over the limit read-only after expiry" by a wide margin, because a downgrade never has to touch data. Get trade-offs like this into the requirements and ADRs early.

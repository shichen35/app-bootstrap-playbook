# 02 · Requirements: FR numbers, platform mapping, glossary

Goal: one set of feature requirements **shared by every platform**, each item numbered and testable, which the architecture, tasks, commits and ADRs all reference.

## Outputs

- `doc/feature-requirements.md` (template [templates/feature-requirements.md](../templates/feature-requirements.md))
- `CONTEXT.md` glossary (template [templates/CONTEXT.md](../templates/CONTEXT.md))

## How to write it

1. **Open with a paragraph naming the baseline**: which version / which research it follows, and the date.
2. **Platform mapping table** (required when porting or going multi-platform): how each concept of the original maps to this platform, and why. Example:

   | Android | iOS | Notes |
   |---|---|---|
   | AlarmManager reminders | Local notifications | iOS caps pending notifications at 64, so only the nearest batch is scheduled |
   | Receiving text shared from other apps | Covered by "Open in App" for now | A Share Extension is expensive; deferred |

3. **FR-n groups**: one user goal per group ("rapid logging", "migrate unfinished tasks", "Collections and Index", …). Each FR-n.m is one testable sentence with numeric bounds ("at most 10 MB and 50,000 entries per import", "consecutive edits within 300 ms are coalesced into one write").
4. **Free / Pro** gets its own group (FR-10). Each item states its tier and what happens on downgrade; decisions cite the ADR.
5. **"Not doing, and why"** section: what is explicitly rejected and why (e.g. social sharing, multi-user collaboration, cloud AI summaries, a web version, …). This section keeps the agent from adding features on its own initiative.
6. Features added later get appended numbers (FR-11, FR-12, …); existing numbers are never renumbered.

## Glossary (CONTEXT.md)

- One entry per domain concept: **Term (Chinese name)**: a one-sentence definition. _Avoid_: words that are easily confused with it.
- Example: "**Migration**: moving an unfinished task to the next month or into the Future Log. The original entry is marked `>`, not deleted. _Avoid_: Move, Copy."
- Code names, UI copy and docs all use the terms in the glossary. Every platform shares the same English terms.

## Gate

- [ ] Every FR has a numeric or observable acceptance criterion.
- [ ] A "Not doing, and why" section exists.
- [ ] The platform mapping table covers every difference from the original.
- [ ] A human has reviewed and confirmed the scope (especially the Pro boundary).

## Lessons

- The agent builds a detail like "the user must explicitly check 'Add valid items only' before the preview" only if the requirements say so. Leave it out and it gets simplified away.
- A Free-tier rule like "limits are checked only at creation and never lock existing content retroactively" beats "make anything over the limit read-only after expiry" by a wide margin, because a downgrade never has to touch data. Get trade-offs like this into the requirements and ADRs early.

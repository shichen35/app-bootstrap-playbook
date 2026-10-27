# 04 · Mock and design: HTML mock, design lab

Goal: before writing UI code, pin down the main screens and interactions in the cheapest medium available, a single HTML file. Once real screenshots exist, run a systematic review and redesign in the design lab.

## HTML mock (before implementation)

For the how-to, see the "Mock" section of the [app-spec](../skills/app-spec/SKILL.md) Skill.

Why HTML: it's the cheapest thing to change, it shows several screens side by side in narrow, wide and short windows, and it needs nothing installed. A human can review a mock far faster than code, and this is the cheapest point to surface disagreements about scope.

## Design lab (once screenshots exist)

After implementation, do one full UI/UX review and put the output in `doc/design-lab/`. For the review format, see [app-screenshot-review/REVIEW-FORMAT.md](../skills/app-screenshot-review/REVIEW-FORMAT.md).

| File | Contents |
|---|---|
| `REVIEW.md` | Screenshot-by-screenshot review, ranked P0/P1/P2; each item reads "screenshot and verifiable observation → proposed fix → acceptance criteria" |
| `UI-SPEC.md` | Written spec for the changes: screen rules, interaction states, where the mock and the platform differ, acceptance criteria |
| `FUNCTIONAL-IMPACT.md` | New entry points the redesign adds, data it brings back into view, visibility costs, features it doesn't cover |
| `dist/index.html`, `compare.html` | Interactive mock of the redesign; before/after views of the same scenario |
| `check.cjs`, `render-check.cjs` | Browser-free checks of page generation and interaction states |

Review principles:

- Lead with conclusions, including what the current structure gets right. Don't tear it down for the sake of a reskin.
- Every issue cites a screenshot number and a **verifiable observation** ("on long entries, the bullet symbol and body text wrap out of alignment"), never a subjective impression.
- Organize proposals around the order of the user's tasks (e.g. "jot it down → review today → migrate at the start of the month"); the design language's emphasis serves those tasks.
- By default, the design lab doesn't touch product source. Findings become tasks only after a human signs off.

Standalone surfaces such as home screen and desktop widgets can get their own studio (`widget-design-lab/`): competitor research, audience, 3–4 options side by side, and the Free / Pro and data boundaries.

## Lessons

- Mocks and reviews live under `doc/` but can stay out of git (list them in `.git/info/exclude`), since screenshots get large.
- Any interaction check a web mock can handle (input formats, duplicate detection) should run as a node script, not by clicking around by hand.

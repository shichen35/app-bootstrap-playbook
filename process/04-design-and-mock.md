# 04 · Mock and design: HTML mock, design lab, UI spec

Goal: before writing UI code, pin down the main screens and interactions in the cheapest medium available, a single HTML file. Once real screenshots exist, run a systematic review and redesign in the design lab.

## 4.1 HTML mock (before implementation)

- One self-contained `doc/mock/ui-mock.html`: phone portrait, detail, add, settings and a wide two-pane layout as side-by-side canvases, with fixed demo data, in plain HTML/CSS/JS and no dependencies.
- Draw it in the platform's design language (Material 3 Expressive / iOS Liquid Glass), encoding status with both color and an icon.
- Cover narrow, wide and short windows. Humans review the mock, not the code.

## 4.2 Design lab (once screenshots exist)

After implementation, do one full UI/UX review and put the output in `doc/design-lab/`:

| File | Contents |
|---|---|
| `REVIEW.md` | Screenshot-by-screenshot review, ranked P0/P1/P2; each item reads "screenshot and verifiable observation → proposed fix → acceptance criteria" |
| `UI-SPEC.md` | Written spec for the changes: screen rules, interaction states, where the mock and the platform differ, acceptance criteria |
| `FUNCTIONAL-IMPACT.md` | New entry points the redesign adds, data it brings back into view, visibility costs, features it doesn't cover |
| `dist/index.html`, `compare.html` | Interactive mock of the redesign; before/after views of the same scenario |
| `check.cjs`, `render-check.cjs` | Browser-free checks of page generation and interaction states |

Review method (template [app-screenshot-review/REVIEW-FORMAT.md](../skills/app-screenshot-review/REVIEW-FORMAT.md)):

1. First, put numbered screenshots in `assets/`, covering every main screen, narrow and wide windows, empty states, error states and notifications.
2. Lead with conclusions, including what the current structure gets right. Don't tear it down for the sake of a reskin.
3. Every issue must cite a screenshot number and a **verifiable observation** ("on long entries, the bullet symbol and body text wrap out of alignment"), never a subjective impression.
4. Organize proposals around the order of the user's tasks (e.g. "jot it down → review today → migrate at the start of the month"); the design language's emphasis serves those tasks.
5. Give every item acceptance criteria ("long entries in English and Chinese, entries with links, and large system text all read in full").
6. P0s go into the next batch of tasks; P1/P2s get scheduled.

Standalone surfaces such as home screen and desktop widgets can get their own studio (`widget-design-lab/`): competitor research, audience, 3–4 options side by side, and the Free / Pro and data boundaries.

## Gate

- [ ] The mock covers the main task flows and all three window shapes.
- [ ] Every review item has screenshot evidence and acceptance criteria.
- [ ] By default, the design lab **doesn't touch product source**. Findings become tasks only after a human signs off.

## Lessons

- Mocks and reviews live under `doc/` but can stay out of git (the macOS version lists `design/` in `.git/info/exclude`), since screenshots get large.
- Any interaction check a web mock can handle (input formats, duplicate detection) should run as a node script, not by clicking around by hand.

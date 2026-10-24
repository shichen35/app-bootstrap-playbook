# 01 · Idea and research: competitors, pricing, positioning

Goal: before writing a single requirement, find out **what's already on the market, where we overlap, where we stand apart, and how others charge**. The findings drive our positioning, the Pro scope and the store copy.

## Inputs

- A one-line idea and the target users (e.g. "a Daily Log written with rapid-logging symbols, with Migration and an Index, for people used to paper journals who also want search and reminders").
- Target platforms and markets (Google Play US, the App Store, etc.).
- Any existing mock or version on another platform (e.g. the iOS version modeled on the existing Android version).

## Steps

### 1. Pick the competitors (about 5)

- The 3–4 most-installed "toolbox" apps in the category, plus 1–2 niche apps **closest in feature shape** to ours.
- For each, record: package name / App ID, one-line positioning, installs, rating, last update, minimum OS, pricing model, and whether an account is required.

### 2. A separate dossier per competitor (`doc/competitors/<name>.md`)

Use **parallel sub-agents**, one per competitor, each verifying the same checklist ([templates/competitor-dossier.md](../templates/competitor-dossier.md)) item by item. Source priority:

1. The store listing (with region and language pinned, e.g. `hl=en_US&gl=US`), the Data safety page, and every store screenshot;
2. The developer's website, help center and changelog;
3. Developer replies in store reviews (**weak evidence**; flag them separately).

If you don't install a competitor, say so: UI conclusions come from store screenshots, which may be out of date.

### 3. Assemble the comparison (`doc/competitor-analysis.md`)

Fixed structure (template [templates/competitor-analysis.md](../templates/competitor-analysis.md)):

1. **Conclusions** first: who has the core shape and who doesn't; where we overlap; what's unique; gaps; differentiation in one sentence.
2. Competitor overview table.
3. Feature comparison tables, grouped by theme. Cells use only the fixed legend `Yes / Paid / No / Not mentioned / Not verified`, with qualifiers in parentheses. "Not mentioned" ≠ "doesn't have it".
4. UI comparison (main screen, result format, navigation, design language, dark mode, tablets, Chinese).
5. Overlap and differentiation: scenarios where users might pick a competitor instead of us; our differentiators; our gaps (and how each relates to our positioning).
6. Method and limitations: before merging, go back to the original sources, **spot-check the key claims**, and record the results.
7. Source list (with access dates).

### 4. Pricing research (`doc/pricing-research.md`)

- Competitor pricing table: model (one-time purchase / subscription / ads / paid download), price (including major regions), what paying unlocks, and Free-tier limits.
- Groups: direct competitors, toolbox apps, reference points from the other platform.
- Conclusion: the pricing model goes into an ADR (e.g. "Free with a banner and up to 3 Collections; Pro as a one-time purchase"). This doc keeps only the evidence and reasoning, plus the price recommendation and experiment plan the ADR leaves out.

## Gate

- [ ] Every cell traces back to a piece of evidence in a dossier.
- [ ] The conclusions state who we are not competing with, and on what (e.g. we don't compete with all-in-one note apps on feature count; we lead with Migration and offline use).
- [ ] Gaps that bear directly on our positioning (e.g. a today's-tasks widget, export / backup) become candidate requirements.
- [ ] The pricing model has a draft ADR awaiting a human decision.

## Lessons

- Parallel agent fact-checking plus a human spot-check of 5–6 key claims is far more reliable than one agent writing everything start to finish.
- Developer replies in reviews can span a decade; label each one with its year.
- If a competitor has lots of "Not mentioned" cells, keep those claims out of store marketing unless you've tested them yourself.
- Research findings feed back into the requirements: research for the Example App added three groups of requirements: home screen widgets, handwriting pages, and export / backup (appended under new FR numbers).

---
name: app-research
description: Research about five competing apps in parallel and write an evidence-backed comparison and pricing study.
disable-model-invocation: true
---

# Competitor and pricing research

## Before you start

If the idea, target users, platforms or regions are still open, settle them first: Call the Skill tool with "grilling", and ask only about these. If that skill isn't available, ask all of them in one message.

## Steps

1. **Pick about 5 competitors**: the 3–4 most-installed tools in the category, plus 1–2 niche apps closest in form. Show the user the list and why you picked each one.
2. **Write the verification checklist**: from this app's requirements or idea, derive 15–30 points to verify one by one (core features, recording method, reminders, widgets, search, export and backup, offline / sync, platform support, pricing, localization).
3. **Dispatch subagents in parallel**, one per competitor, each with a self-contained brief:
   - Competitor name, store URL (pinned to `hl=en_US&gl=US` or the target region), official website.
   - The full checklist and the legend (Yes / Paid / No / Not mentioned / Not verified).
   - Evidence-strength rules: the store page, Data safety, screenshots, official website and help center are strong; reviews and developer replies are weak and must note the year.
   - Write output to `doc/competitors/<name>.md` using [DOSSIER-FORMAT.md](DOSSIER-FORMAT.md) (paste its full text into the brief).
   - Don't install competitors; record observations for each screenshot separately.
4. **Merge** the dossiers into `doc/competitor-analysis.md` using [ANALYSIS-FORMAT.md](ANALYSIS-FORMAT.md): conclusions first → overview → feature comparison (one table per theme) → UI comparison → overlap / differentiators / gaps (judge whether each gap matters for the positioning) → method and limits → sources.
5. **Spot-check**: go back to the original sources and verify 5–6 key claims. Record the results under "Verification method and limits".
6. **Pricing**: write `doc/pricing-research.md` using [PRICING-FORMAT.md](PRICING-FORMAT.md): three price tables (direct competitors, toolboxes, the other platform), a model analysis, and recommendations (the model goes into an ADR; prices and experiments stay in this doc).

## Rules

- "Not mentioned" does not mean "doesn't have it", and never goes into marketing copy.
- Every cell must trace back to evidence in a dossier.
- The conclusions should be able to change the requirements that follow: list gaps directly relevant to the positioning as requirement candidates and let the user decide.
- Date everything; give every price with its region.

## Done when

- Every comparison cell has evidence and an evidence strength.
- The conclusions state who we don't compete with, and on what.
- The spot-check results are recorded under "Verification method and limits".

In your reply to the user, give the file list, three conclusions, and the requirement candidates the user needs to decide on. Suggest `/app-spec` as the next step.

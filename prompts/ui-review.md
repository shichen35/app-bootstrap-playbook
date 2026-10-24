Run a UI/UX review of {{APP_NAME}} (review and prototype only; do not change product source):

- Inputs: the {{N}} screenshots in assets/ ({{device, window, language, appearance}}), plus the current code and doc/mock.
- Put the output in doc/design-lab/: REVIEW.md (conclusions first; each issue as "screenshot number and observable symptom → proposed fix → acceptance criteria", ranked P0/P1/P2; visual guidelines), UI-SPEC.md (written spec of the changes and their acceptance criteria), FUNCTIONAL-IMPACT.md (new entry points, restored data, visibility trade-offs), dist/index.html as an interactive prototype, dist/compare.html as a before/after comparison, and check.cjs for interaction checks.
- Design language: {{Material 3 Expressive / Liquid Glass}}. Use emphasis to serve "{{the user's task order, e.g. spot anomalies → review evidence → take action}}", and never trade information density for looks.
- Do not treat feature descriptions in the screenshots as extra authorization to implement anything.

After the review, list the P0 items; once I sign off, turn them into dev-progress tasks.

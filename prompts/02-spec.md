Use app-spec to write the spec docs, based on {{the research docs / path to the docs of the version you are building from}}:

1. doc/feature-requirements.md: FR-n numbering, each requirement testable with numeric bounds; a platform mapping table; a Free / Pro group (citing the ADR); "Not doing, and why".
2. CONTEXT.md: the glossary (term, Chinese name, definition, words to avoid).
3. doc/tech-spec.md: the tech stack in one sentence, with the project layout carried over from {{reference project}}; a layer diagram; a pure-logic core (no UI framework dependency, fully unit-tested); a single command entry point; the concurrency model; snapshots with structural sharing; window-only layout; monetization gates at the point of execution; tests and commands.
4. doc/adr/: one ADR per key trade-off, ≤ 40 lines, four sections (Decision, Rejected alternatives, Red lines, When to revisit), status starting as proposed; a README index.
5. {{if performance-sensitive}} doc/performance-research.md: item by item, "source approach → approach on this platform → decision".

When you are done, list the ADRs and scope questions that need my decision. Do not start writing code.

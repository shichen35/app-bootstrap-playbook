# ADR format

ADRs live at `doc/adr/NNNN-<short-phrase>.md`, numbered one above the current highest. Each ADR is at most 40 lines with four fixed sections: **Decision** · **Rejected alternatives** · **Red lines** · **When to revisit**. Mechanics belong in the code and `doc/tech-spec.md`; an ADR records only the why.

## Single-ADR template

```md
# ADR-{{NNNN}} — {{the decision in one sentence}}

- Status: {{proposed / accepted / partly superseded by NNNN}}
- Date: {{YYYY-MM-DD}}

## Decision

{{what was decided, down to the numbers and boundaries}}

## Rejected alternatives

- **{{Option A}}**: {{why not}}.
- **{{Option B}}**: {{why not}}.

## Red lines

- {{rules future changes must not break, one per line; mirror them in CLAUDE.md}}

## When to revisit

{{the conditions that trigger a re-evaluation}}
```

## Index `doc/adr/README.md`

Update this table every time you add an ADR, and mirror its red lines into the Hard rules in CLAUDE.md.

```md
# ADR index

| # | Summary | Status |
|---|---|---|
| [0001](0001-follow-{{ref}}-layout.md) | Project layout, dependency versions and build rules follow {{reference project}} | accepted |
| [0002]({{…}}) | {{minimum OS version and why}} | accepted |
| [0003]({{…}}) | {{concurrency / snapshot model}} | accepted |
```

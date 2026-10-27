## What it does

Writes the full spec before any product code exists: numbered requirements (FR-n), a glossary, a tech-spec, ADRs, performance research and a single-file HTML mock. The requirement numbers anchor everything that follows: commits, ADRs, the decision log and the other platform's implementation all cite the same FR-n.

## When to reach for it

Type `/app-spec`, or let the agent pick it up when you say "write the requirements", "design the architecture" or "write an ADR". It first uses `grilling` to pin down idea details that are still open, then `domain-modeling` to sharpen the terms and decide which trade-offs deserve an ADR.

## Common questions

**`domain-modeling` says one paragraph is enough for an ADR. Why four fixed sections here?**
The "red lines" section gets copied into the Hard rules in CLAUDE.md, which the agent reads every time it starts work. The "When to revisit" section tells future readers under what conditions they can overturn it. Everything else (when an ADR is worth writing, how to challenge terms) follows `domain-modeling`.

**Why an HTML mock instead of writing the UI in code?**
HTML is the cheapest thing to change, and you can view several screens in narrow, wide and short windows side by side. Reviewing a mock is far faster for you than reviewing code.

## It's working if

- Every FR has numeric bounds, so tests and acceptance checks can be written straight from it.
- There is a "Not doing, and why" section, and someone has since cited it to turn down a request.
- When someone later questions a design choice, you can just point them to an ADR.

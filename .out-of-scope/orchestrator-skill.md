# Orchestrator skill

This repo no longer accepts an orchestrator skill that runs the whole way from idea to store release.

## Why

The original `app-bootstrap` was exactly that. It restated every stage's rules, so it, the stage skills and the `process/` docs became three sources of truth, and updating one left the other two stale. It also kept running forward, making decisions that belong to a human (the ADR option, the Pro boundary, whether to push).

The current approach: `ask-playbook` only points the way, each stage skill owns its own stretch, work stops between stages, and a human decides where to go next.

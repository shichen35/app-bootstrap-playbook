# {{APP_NAME}}: feature requirements

This doc is based on {{baseline: original docs / research conclusions}} ({{date}}). Item by item, it states what the app does, how each item maps to this platform, and what it doesn't do and why. FR-n numbers are for commit messages and other docs to reference; new features get new numbers appended, and nothing is renumbered.

## Platform mapping

| {{source platform}} | {{this platform}} | Notes |
|---|---|---|
| {{concept / mechanism}} | {{how this platform does it}} | {{why}} |

## FR-1 {{user goal one}}

- FR-1.1 {{one testable sentence with numeric bounds}}.
- FR-1.2 {{…}}.

## FR-2 {{user goal two}}

- FR-2.1 {{…}}.

<!-- Common groups: core features, adding and managing, lists and browsing, detail and history, reminders and notifications, entry actions, search, export and backup, background operation, settings, Free and Pro, extensions (widgets, handwriting, etc.) -->

## FR-N Free and Pro

Decision and rationale: [ADR-{{NNNN}}](adr/{{NNNN}}-….md).

- FR-N.1 Free: {{limits, e.g. at most 3 Collections, checked on creation}}.
- FR-N.2 Pro: {{one-time purchase / subscription; what it unlocks; display features stay free}}.
- FR-N.3 Ads: {{placement, when they are hidden, consent flow}}.
- FR-N.4 Upgrade entry points: {{a single upgrade screen, the triggers, no unprompted upselling}}.
- FR-N.5 Restore and downgrade: {{no data changes, running tasks keep running}}.
- FR-N.6 Trial: {{rewarded ad / duration / rules}}.

## Not doing, and why

- {{feature}}: {{reason (platform limit / positioning / cost)}}.

# {{APP_NAME}}: architecture

{{tech stack in one sentence}}, package name `{{…}}`. Project layout, dependency versions, and build and lint rules follow {{reference project}} (see [ADR-0001](adr/0001-….md)).

## Layers

```text
┌────────────────────────────────────────────────┐
│ ui/  {{screens ─ ViewModel ─ projections}}     │
└───────────────┬────────────────────────────────┘
                │ {{StateFlow / @Observable}}, commands
┌───────────────┴────────────────────────────────┐
│ {{monitor / app}}  single command entry point  │
├────────────────────────────────────────────────┤
│ data/  settings ─ storage ─ export             │
├────────────────────────────────────────────────┤
│ core/  pure logic, unit-tested                 │
├────────────────────────────────────────────────┤
│ net / platform/  platform implementations      │
└────────────────────────────────────────────────┘
```

## core/

### {{parsing}}
### {{engine: concurrency model, scheduling, snapshots}}
### {{other: reports, templates, statistics}}

## {{platform}}/

{{for each platform implementation: which API it uses, plus a table of differences from the source platform}}

## {{monitor / app}}/

{{command entry point, background tasks, reminders}}

## data/

{{settings storage pattern, domain data storage, threading for file I/O}}

## ui/

{{navigation, projections, list performance, detail data fetched on demand}}

## Monetization

{{SDK, key management, initialization conditions, banner, rewarded ads, entitlements, gates placed where actions execute}}

## Windows and foldables / iPad

{{criteria: window width / height only; measurement table}}

## Testing

- core/ is fully unit-tested ({{list}}).
- {{instrumented tests}}.

## Commands

```bash
{{…}}
```

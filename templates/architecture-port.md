# {{APP_NAME}} for {{new platform}}: architecture

{{APP_NAME}} {{one-sentence description}}. This is the {{new platform}} port of {{source platform}}. Features follow {{FR source}}; {{code reuse source (when same language)}}; the UI is rebuilt to {{design language / HIG}}.

- Minimum OS {{version}} (because it needs {{required API}}).
- {{language mode, concurrency checking, UI framework}}.
- Identifiers: {{bundle ID / package name, App Group, product IDs}}.

## Project layout
```text
{{directory tree, marking the pure-logic module, app, extensions, Config, tools, doc}}
```

## Layers
```text
{{layer diagram}}
```

### {{reused core}} (reused from {{source platform}})
{{what was copied, what was added to the copy, where the upstream commit hash is recorded}}

### {{pure-logic module}} (pure logic ported from the {{source platform}} app layer)
{{what was moved over, what is new}}

### {{command entry point / Model}}

## Platform mapping

| {{source platform}} | {{new platform}} | Notes |
|---|---|---|
| {{mechanism}} | {{equivalent approach}} | {{reason / substitute / not doing}} |

## UI ({{design language}})
{{system components first; how custom floating controls are built; status color + icon; row layout}}

## Performance
## Testing and checks

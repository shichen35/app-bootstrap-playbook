# 11 · Multi-platform: an independent native app per platform

Our recommendation: one independent repo per platform, each with its own native implementation. What the platforms share is **the requirement numbers, the terminology, the test scenarios and the reasoning behind each trade-off**, not a cross-platform framework. The Example App shipped on Android first, then iOS.

## Why not a cross-platform framework

- A good experience depends on each platform's native capabilities, and those differ widely: handwriting (Jetpack Ink / PencilKit), system widgets (Glance / WidgetKit), reminder and background models, files and sharing.
- The UI should follow each platform's latest design language (Material 3 Expressive, Liquid Glass), and system components deliver that best.
- Native code is cheap for an agent to write, so a separate native app per platform is actually less work than maintaining an abstraction layer.

## Platform mapping table

For the how-to, see the [app-platform-port](../skills/app-platform-port/SKILL.md) Skill. Its main output is the platform mapping table in the new platform's `architecture.md`: for every mechanism on the source platform, what the new platform uses, why, and what replaces anything it can't do. From the Example App:

| Android | iOS | Notes |
|---|---|---|
| Room | SwiftData | Same schema and migration rules; test scenarios carried over |
| Glance widgets | WidgetKit | Summaries written to a shared container and refreshed on change |
| Jetpack Ink | PencilKit | Each side keeps its native ink format; export converts both to images |
| AlarmManager reminders | Local notifications (64 pending max) | Only the nearest batch is scheduled |
| Receiving text shared from other apps | Share Extension (or "Open in App" for now) | Scope trade-off recorded in the decision log |

## Why copied tests must pass unchanged first

Within the same language, copy the core code and its tests wholesale. If the tests pass unchanged on the new platform, the move broke nothing, and anything added to the copy afterward comes with its own tests. Change the code before running the tests and you can't tell whether a failure came from the move or from your edits. Across languages (Kotlin ↔ Swift) you have to rewrite from the tech-spec, but the test scenarios carry over as is.

## Typical categories of platform differences

| Category | Examples | Handling |
|---|---|---|
| Not allowed by the OS | Long-running background work on iOS; iOS's cap on local notifications; Android exact alarms need a permission | Use an alternative and document its limits |
| Different design language | Snackbar ↔ floating glass bar; top chips ↔ title menu / sidebar; long-press multi-select ↔ edit mode | Rebuild to platform conventions while keeping the FR's behavior |
| SDK differences | One banner size in the ads SDK deprecated on one platform; StoreKit 2 caches entitlements offline | Use the currently recommended API and record how it differs from the other platform |
| Tooling differences | No XcodeGen / SwiftLint | Hand-write the pbxproj (folder sync groups); use the swift-format that ships with Xcode |

## Localization

- Every platform ships complete in both English and Simplified Chinese, using its native mechanism (Android `values-b+zh+Hans`, iOS String Catalog).
- Export formats (column names and symbols in CSV and Markdown) stay fixed regardless of UI language; translation happens in the app layer.
- The check script guarantees nothing is left untranslated.

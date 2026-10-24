# 11 · Multi-platform: an independent native app per platform

Our recommendation: one independent repo per platform, each with its own native implementation. What the platforms share is **the requirement numbers, the terminology, the test scenarios and the reasoning behind each trade-off**, not a cross-platform framework. The Example App shipped on Android first, then iOS.

## Why not a cross-platform framework

- A good experience depends on each platform's native capabilities, and those differ widely: handwriting (Jetpack Ink / PencilKit), system widgets (Glance / WidgetKit), reminder and background models, files and sharing.
- The UI should follow each platform's latest design language (Material 3 Expressive, Liquid Glass), and system components deliver that best.
- Native code is cheap for an agent to write, so a separate native app per platform is actually less work than maintaining an abstraction layer.

## Porting process

1. **Read three things**: the source platform's FRs, its tech-spec / architecture doc, and its decisions (ADRs / decision log). For features, follow the most complete platform; if there's a platform in the same language (e.g. an existing macOS version when building iOS), take the code from that one.
2. **Write the new platform's `architecture.md`**, centered on the **platform mapping table**: for every mechanism on the source platform, what the new platform uses, why, and what replaces anything it can't do. From the Example App:

   | Android | iOS | Notes |
   |---|---|---|
   | Room | SwiftData | Same schema and migration rules; test scenarios carried over |
   | Glance widgets | WidgetKit | Summaries written to a shared container and refreshed on change |
   | Jetpack Ink | PencilKit | Each side keeps its native ink format; export converts both to images |
   | AlarmManager reminders | Local notifications (64 pending max) | Only the nearest batch is scheduled |
   | Receiving text shared from other apps | Share Extension (or "Open in App" for now) | Scope trade-off recorded in the decision log |

3. **Open the decision log by stating**: "which platform defines the features, which platform the code comes from, and what the UI is rebuilt to", "copy or cross-repo dependency", and "minimum OS version".
4. **Copy the core code within the same language**: copy it wholesale with its tests and record the upstream commit hash (`UPSTREAM.md`); then add what the new platform needs on top of the copy (with tests). Get the tests passing unchanged on the new platform before touching anything else. Across languages, rewrite from the tech-spec and carry the test scenarios over as is.
5. **Move the app layer's pure logic too** (list projection, selection, import preview, Migration rules): strip the UI dependencies and English titles and put it in the new platform's pure-logic module.
6. Reorder the task list for the new platform, tag each task name with its FR number, and implement them one by one.
7. Finish with a **feature parity table**: mark each FR "same / substitute (reason) / not doing (reason)", in the README or the decision log's Wrap-up.

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

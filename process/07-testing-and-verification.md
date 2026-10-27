# 07 · Testing and verification: unit tests, instrumented tests, debug hooks

Tests run as part of the task loop (see [app-task-loop](../skills/app-task-loop/SKILL.md)). This doc covers the test layers, how to write the tests, and how to verify behavior when the agent can't tap the screen.

## Test layers

| Layer | Runs on | Covers | Speed |
|---|---|---|---|
| Pure-logic unit tests | Dev machine (JVM / `swift test`) | Entry parsing, date and recurrence math, Migration rules, Index generation, import/export, list projection, Free-tier rules, deep links | Seconds; every commit |
| Storage tests | Dev machine (in-memory database) | Schema migrations, full-text search, bulk-import transactions | Seconds |
| Platform instrumented tests | Emulator / simulator | Android: instrumented tests for database migrations, reminder scheduling and widget rendering; iOS: rerun the package tests on the simulator (`xcodebuild test -scheme <Kit>-Package`) | Minutes; at milestones |
| UI verification | Emulator / simulator screenshots | See [09](09-ui-review-and-polish.md) | At milestones |

## Lessons from writing tests

- Every non-trivial rule in a pure-logic module gets a test: branches, loops, parsing, billing / entitlement rules, anything security-related.
- For time-dependent logic such as dates and reminders, prefer a **fake clock** and cover month ends, leap years, time zones and DST transitions. Tests on real time need generous margins, because they get flaky on CI and under load (see [13](13-lessons-learned.md)).
- When you move code, move its tests with it. Copied tests passing on the first run on the new platform proves the port is correct.
- Test the failure modes too: over-limit input rejected rather than clamped, non-UTF-8 files, empty input, expired trials, migrating to a month that doesn't exist.

## Debug launch hook (Debug only)

The agent often can't tap the simulator (due to permissions or tooling limits). Add a launch-argument dispatcher to the Debug build that opens any screen directly, with its state already set up:

```swift
#if DEBUG
enum DebugLaunch {
    static func apply(to model: AppModel) async {
        switch UserDefaults.standard.string(forKey: "screen") {   // -screen month
        case "add": model.showingNewEntry = true
        case "month": model.openMonth(.current)
        case "upgrade": model.upgradeReason = .collectionLimit
        ...
        }
    }
}
#endif
```

Pair it with `-tier FREE|PRO` (force a tier), `-month 2026-02` (open a given month), `-entry <id>`, `-columns all` (show every column on wide screens), `-demo large` (50,000 demo entries) and `-AppleLanguages "(zh-Hans)"`. On Android, use `adb shell am start -e screen month` or a debug menu.

Debug launches should suppress system prompts that would block screenshots (such as the notification permission request). A pending system prompt survives an app relaunch; only restarting the simulator clears it.

## Devices

- Use only the agreed-upon simulators (Android: one foldable AVD with its window visible; iOS: one phone and one large-screen tablet), and list their names in CLAUDE.md. Never create or delete AVDs.
- If the simulator runtime is missing (on a fresh Xcode install), run `xcodebuild -downloadPlatform iOS` (about 8 GB, downloads in the background; build against `generic/platform=iOS Simulator` in the meantime).
- Reset `wm size`, `wm density` and rotation after changing them. Test foldables in both postures.

## Verification only a human can do

Real-device behavior (notification and exact-alarm permissions, background wake-up timing, stylus pressure), real purchases and restores, and interactions that need a tap (long-press menus, swipes, chart inspection, file pickers). The Wrap-up section of the decision log lists each of these.

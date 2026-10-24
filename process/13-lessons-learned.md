# 13 · Lessons learned

Grouped by topic. Skim this list before starting a new project.

## Process

- **Pipes swallow exit codes**: `check.sh | tail -1 && git commit` commits even when the checks fail. Use `set -o pipefail`, or write to a log file first and then check the exit code.
- **Flaky time-dependent tests**: engine tests running on real time occasionally exceeded their thresholds when the CPU was busy (simulator and ads running at once), and the failures couldn't be reproduced. Use a fake clock for time-dependent tests, or leave generous margins and log the issue in the decision log.
- **When the agent can't tap**: open screens with debug launch arguments, and explicitly hand anything that needs a tap to verify over to a human.
- **Long sessions get interrupted**: set up a scheduled wake-up when work starts, with a prompt that resumes from the first unchecked item in dev-progress; delete the scheduled task when everything is done.
- **One file vs. many ADRs**: if the user wants all decisions in a single md file, use the decision log (D-n / P-n); otherwise, record long-term trade-offs in ADRs.

## iOS / Xcode

- A fresh Xcode install has no simulator runtime: run `xcodebuild -downloadPlatform iOS` (about 8 GB) and build against `generic/platform=iOS Simulator` in the meantime.
- `xcodebuild` doesn't sync the String Catalog: run `xcstringstool sync` yourself, then remove stale keys and check the Chinese strings.
- Some concurrency diagnostics ignore `SWIFT_TREAT_WARNINGS_AS_ERRORS`: have the check script scan the output for `warning:` lines from this repo, and clear the app target's intermediate build products first so every file gets recompiled.
- Under `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`, a static logger used inside callback closures must be `nonisolated static let`.
- System framework type names can collide with your own (e.g. certain types in the `Network` framework). When they do, qualify the name with its module.
- Inside a NavigationSplitView column the size class is compact, so any width-based logic in the list has to measure the width itself.
- `List(selection: Set<ID>)` on iPhone pushes the detail view as soon as one item is selected, and can still support multi-select in edit mode.
- When Settings is itself a Sheet, the root view can't present another Sheet: have Settings present it, and have the root view stand down while Settings is open.
- Opening a NavigationStack subpage directly makes the large title cover the first row: use inline titles on subpages.
- On iOS 26, a long top-bar subtitle collapses the top-right button into "…".
- Using AdMob's `BannerView` directly as a `UIViewRepresentable`'s view lets SwiftUI frame changes distort the ad's aspect ratio. Put it inside a plain container `UIView`, and use a width measured outside the banner; measuring on the banner's own container creates a feedback loop that keeps growing it. GMA 13 deprecated the standard anchored adaptive banner.
- `simctl` can't grant notification permission, and a pending system prompt survives app relaunches; restart the simulator.
- A StoreKit configuration only applies when running from Xcode; launched via `simctl launch`, the app can't fetch products.
- In a hand-written pbxproj, keep Info.plist outside the synced folder (otherwise it gets copied as a resource), and make sure the 1024 App Icon has no alpha channel.

## Android

- When a critical system API is public only from a newer API level, that level sets the minimum version. Record it in an ADR, including the condition under which it no longer holds ("to support lower versions, switch to JNI or another approach").
- A new targetSdk often brings new runtime permissions (local network access, exact alarms, notifications). When one is denied, explain why and link to Settings, and report the error as a permission problem rather than a generic failure.
- When instrumented tests need an Activity in the foreground, wake and unlock the emulator before running them.
- Don't use the SDK's automatic preloading for rewarded ads: in a long-lived process (a foreground service, a sync job), automatic refills turn into background network requests.
- Layout decisions are window-only: any "is this a foldable device" check is a regression.

## Design / product

- Check Free limits only at creation time and never lock existing content retroactively, so a downgrade never has to change data.
- Don't convey state through color alone. "Unavailable because it's over the free limit" and "archived by the user" are two different states and need distinct treatments.
- In Chinese, don't prefix times with a day period (such as "early morning" or "morning"); show historical times in 24-hour format with no AM/PM.
- A competitor's "Not mentioned" cell must never be presented as "doesn't have it" in marketing.

---
name: app-screenshot-review
description: Take screenshots of an app on the iOS Simulator or Android emulator (via debug launch arguments when tapping is not possible), read them, find layout and design problems against a checklist (truncation, overlap, duplicates, system conventions, i18n, dark mode, wide windows, ad and paywall placement), fix them and record the milestone. Use for "screenshot review", "check it in the simulator", "polish the UI", milestone review in app-task-loop.
---

# Screenshot review and polish

Process: `<playbook>/process/09-ui-review-and-polish.md`; debug hooks: `process/07-testing-and-verification.md`. Script: `tools/ios/shot.sh`.

## Get screenshots

- Try the platform's simulator panel / control tools first; if they aren't authorized, use the command line:
  - iOS: `tools/shot.sh <out.png> <screen> [device] [args…]` (builds, installs, seeds demo data, runs `simctl launch -screen …`, takes the screenshot, scales it to 1200 px). Dark mode: `xcrun simctl ui <dev> appearance dark`; Simplified Chinese: `-AppleLanguages "(zh-Hans)" -AppleLocale zh_CN`; tier: `-tier FREE|PRO`.
  - Android: `adb exec-out screencap -p > out.png`; `adb shell am start ... -e screen <name>`.
- If you can't navigate to a screen, first add a `DebugLaunch` branch to the debug build (only under `#if DEBUG` / in the debug source set).
- Don't request system dialogs that would cover screenshots (notification permission and the like) on a debug launch; restart the simulator to clear one that's already pending.

## Screenshot checklist

1. Truncated text or bad line breaks (names, units, subtitles, buttons).
2. Overlap: floating toolbars, buttons, ads, the keyboard and sheets covering one another.
3. Duplicate information (the title and the header showing the same name).
4. System conventions: stray dividers, large titles crowding the content, cramped axis labels, Chinese time labels with a day-period prefix such as "morning" / "early morning".
5. Status encoded twice (color + icon / text); empty, error and no-permission states.
6. Check English and Simplified Chinese, light and dark, narrow and wide windows (iPad, foldables).
7. Ad and paywall placement respects the ADR red lines; check both Free and Pro.
8. Key screens at large Dynamic Type sizes.

## Fix and record

- For each problem: change the code → re-shoot to confirm → move on.
- Save screenshots to `doc/screenshots/mN-<screen>-<lang>.png` (milestones) or `final-*.png`; **never commit screenshots that reveal the user's real environment** (real notes, accounts, device names).
- Add a "Milestone Mn" entry to `doc/decisions.md`: the screenshot files, what you saw, what you fixed, and what was not verified.

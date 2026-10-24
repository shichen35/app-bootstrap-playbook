# 09 · Screenshot review and UI polish

Goal: the agent captures screenshots in the simulator, reads them, finds the problems and fixes them before a human ever looks.

## How to capture screenshots

- iOS: `tools/shot.sh <out.png> <screen> [device] [launch args…]` (see [tools/ios/shot.sh](../tools/ios/shot.sh)): builds, installs, seeds demo data on first run, runs `simctl launch -screen …`, waits, runs `simctl io screenshot`, and downscales to 1200 px before reading (to save tokens).
- Android: `adb exec-out screencap -p > out.png`; on a foldable, switch postures with the extended controls / `adb emu fold`.
- macOS: an in-app screenshot hook renders the window to a PNG (`design/capture.py`), using a separate data directory for each shot.
- Dark mode: `xcrun simctl ui <device> appearance dark`; language: `-AppleLanguages "(zh-Hans)" -AppleLocale zh_CN`.
- Keep demo data in the repo (e.g. `tools/demo-entries.json`), covering every bullet symbol, long entries, Migration across months and empty months. **Never commit screenshots containing real user data** (real notes, accounts, device names).

## What to check at each milestone (checklist)

- [ ] Truncation: are titles, names, units or subtitles cut off with `…` or wrapped in the wrong place?
- [ ] Overlap: do floating toolbars / buttons / ads / the keyboard cover content or each other?
- [ ] Duplication: is the same information shown twice (a date in both the title and the header)?
- [ ] Platform conventions: stray dividers between segmented controls, a large title covering the first row, AM/PM crowding the chart axis, Chinese time labels with a day-period prefix such as "early morning".
- [ ] Status: an icon / text in addition to color; empty, error and no-permission states.
- [ ] Both languages (English and Chinese), both appearances (light and dark), both window widths (narrow and wide: iPad / foldable).
- [ ] Key screens with Dynamic Type / large text sizes.
- [ ] Ad and paywall placement follows the ADR's red lines.

## Common self-review findings and fixes

| Symptom | Fix |
|---|---|
| A long entry containing a link is truncated to `https:/…com/` | Show the link's title or domain inline; put the full link in the detail view |
| In a filled-in edit form, you can't tell which field is which | Switch to form rows with the label on the left and the input on the right |
| Opening a settings subpage directly, the large title covers the first row | Use inline titles on every subpage |
| With a long subtitle, iOS collapses the top-right button into "…" and "Add" disappears | Move "Add" into the bottom toolbar, to the right of the search field |
| AM/PM labels crowd each other on the timeline; Chinese time labels with a day-period prefix such as "early morning 12:24" | Use 24-hour time everywhere, with no AM/PM |
| The banner covers the floating toolbar and content overflows | Place the banner in the list's safe area; wrap `BannerView` in a container |
| The upgrade screen's bottom buttons overlap the scrolling content | Use iOS 26 `safeAreaBar` (with the scroll edge effect) |

## Design language essentials

- **iOS 26 Liquid Glass**: get glass from system components wherever possible (navigation bars, toolbars, search, Sheets, menus), and don't give them background colors. Reserve `.glassEffect(...)` for custom floating controls, grouping several in a `GlassEffectContainer`. Primary actions use `.buttonStyle(.glassProminent)`, secondary ones `.glass`. Bottom floating areas use `safeAreaBar`; group toolbar items with `ToolbarSpacer`; put a status summary in `navigationSubtitle`; put search in the bottom toolbar (`DefaultToolbarItem(kind: .search, placement: .bottomBar)`).
- **Material 3 Expressive**: colors come only from `colorScheme` tokens and type only from typography tokens; don't give a fixed height to any text control whose content might not fit; use emphasis to serve the task, not to decorate.
- On both platforms: encode status with both a color and an SF Symbol / Material icon; use tabular figures for numbers; layout is window-only.

## Wrap-up

Screenshots go in `doc/screenshots/` (mN-*.png for milestones, final-*.png for the final set); review findings go under "Milestone Mn" in the decision log.

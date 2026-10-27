# 09 · Screenshot review and UI polish

Goal: the agent captures screenshots in the simulator, reads them, finds the problems and fixes them before a human ever looks.

For how to capture, which checklist to review against, and how to record the results, see the [app-screenshot-review](../skills/app-screenshot-review/SKILL.md) Skill. The iOS screenshot script is at [app-scaffold/scripts/ios/shot.sh](../skills/app-scaffold/scripts/ios/shot.sh).

## Why the agent reviews its own screenshots

Code that looks right doesn't guarantee a UI that looks right. Truncation, overlap, bad line breaks in Chinese and text that disappears in dark mode only show up in screenshots. When the agent captures, reads and fixes at every milestone, the human receives a UI that has already had one round of self-review and only needs to check what the agent can't. Downscale screenshots to 1200 px before reading them to save tokens.

Capturing on other platforms:

- On an Android foldable, switch postures with the extended controls or `adb emu fold`.
- macOS has no simulator: an in-app screenshot hook renders the window to a PNG, using a separate data directory for each shot.
- Keep demo data in the repo (e.g. `tools/demo-entries.json`), covering every bullet symbol, long entries, Migration across months and empty months.

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

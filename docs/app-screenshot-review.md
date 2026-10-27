## What it does

Takes screenshots in the simulator and reviews each one against a checklist (truncation, overlap, duplicated information, platform conventions, English and Simplified Chinese, light and dark mode, wide and narrow windows, ad and paywall placement), then changes the code, reshoots to confirm, and records the findings in the decision log. The agent takes and reads the screenshots itself; you do not need to tap through the app for it.

## When to reach for it

Type `/app-screenshot-review`, or let the task loop call it automatically at milestones. It also kicks in when you ask to "screenshot it and take a look" or "polish the UI".

## Common questions

**Some screens take several taps to reach, and the agent cannot tap. What now?**
Add a launch argument to the Debug build (for example `-screen settings`) that opens that screen directly. It lives only in Debug code and never ships in the release build.

**A notification permission dialog is covering the screenshot?**
Do not request permissions on a Debug launch. A dialog that is already showing only goes away when you restart the simulator.

**Can screenshots be committed as is?**
First check them for real notes, accounts or device names. If you find any, reshoot with the repo's demo data rather than blurring them out.

## It's working if

- Every milestone has an entry in the decision log: which screenshots were taken, what was found, what was fixed.
- Chinese-language and dark mode issues surface at milestones, not right before release.

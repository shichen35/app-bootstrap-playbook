# 10 · Monetization: Free / Pro, ads, rewarded trial, in-app purchase

Take the Example App: Free shows a banner and allows up to 3 Collections. Pro is a one-time purchase (priced per the pricing research) that removes ads and unlocks the advanced and automation features. Watching one rewarded ad grants a 24-hour Pro trial. The rules below carry over to other apps.

## Drawing the line (as an ADR)

- **Capturing and viewing are free; scale and automation are paid.** Rapid logging, the Daily / Monthly / Future Logs, Migration, search, reminders and manual export are all free. Pro covers going past the Collection limit, extra themes, handwriting pages, automatic backup to a folder the user picks, the full task list in widgets, and productivity features such as opening straight to a chosen page.
- **Limits are checked at creation time**, and existing content is never affected. When the user hits a limit, offer a choice (upgrade / cancel); never quietly disable older content.
- **A downgrade never touches data.** After a refund or an expired trial, notes and settings stay exactly as they were. Existing Collections remain readable, editable and exportable; the user just can't create new ones past the limit. Locked settings keep their values but stop taking effect, and everything comes back when the user returns to Pro.
- Keep the rules in **one tested rule table** (`ProFeatures` / `ProGate` in the pure-logic module). Gates sit where the action runs (creation, backup jobs, widget refresh); the UI only shows locks and opens the upgrade screen.

## Red lines (copy into CLAUDE.md)

- A downgrade or expiry must never delete, hide or rewrite user data, or interrupt an edit in progress.
- Never play a rewarded ad without a user tap. Never upsell from a timer, on return to the foreground, or from a widget.
- Lists and the status bar never show a live trial countdown (show only the fixed expiry time).
- Capturing and viewing core content never requires watching an ad.
- Never initialize the ads SDK for users who bought the one-time purchase.

## Ad integration

- Consent: run UMP first (showing the form when required), and initialize the SDK only once `canRequestAds` is true, waiting ~2 seconds after the first frame. Provide "Ad privacy options" in settings when required.
- Banners: anchored adaptive, with the placement recorded in an ADR (e.g. on Android, at the bottom of the app in single-pane layout and only in the list pane in dual-pane; on iOS, at the bottom of the list above the toolbar). Hide the banner on edit and settings screens, while the keyboard is up, and in short windows. If it fails to load, keep it hidden until the width changes.
- Rewarded ads: load only when the upgrade screen opens; no preloading and no background refills. Grant the reward **after the ad is dismissed**. If no ad is available, disable the button and say why; without consent, don't show the button at all.
- Ad unit IDs come from build config and default to Google's test IDs. A Release build without real IDs should fail to build or get caught by the release checklist.

## Purchase integration

- One non-consumable product. Android: Play Billing, acknowledge after purchase, and keep a signed local entitlement cache as an offline grace period. iOS: StoreKit 2, where `Transaction.currentEntitlements` already caches offline; also persist a "last known purchased" flag for decisions at launch.
- Refresh entitlements at launch and on return to the foreground; listen via `Transaction.updates` / `PurchasesUpdatedListener`.
- Put Restore Purchases in settings and on the upgrade screen.
- Local testing: on iOS, attach the `.storekit` configuration to a shared scheme (it only applies when running from Xcode); on Android, use test accounts and license testing.
- Debug switch: `DEBUG_TIER` / `-tier FREE|PRO` forces a tier.

## Upgrade screen

A single upgrade screen for every entry point. The title states what triggered it ("Create more Collections with Pro"); the body lists what Pro includes and the price; the buttons are Buy / Restore / Cancel, plus "Watch an ad for a 24-hour trial" when available. Locked settings stay visible, marked PRO. The screen appears only in response to a user action.

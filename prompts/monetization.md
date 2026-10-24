Add monetization to {{APP_NAME}}:

- Model: {{Free tier with a banner + a limit of N; Pro as a one-time purchase (price); watch a rewarded ad for an X-hour trial}}. Write the ADR first (Pro boundary, limit checked at start, a downgrade never changes data, trial rules, red lines), and implement only after I sign off.
- Keep the rules in one tested rule table (a pure-logic module) and put the gates at the point of execution. Locked settings stay visible with a PRO badge; tapping one opens the shared upgrade screen (a title stating why, what Pro includes, price, buy / restore / cancel; at start it also offers "use only the first N", and when available it also offers "watch an ad to try it").
- Ads: {{AdMob}} + UMP consent; do not initialize the SDK for one-time-purchase users. Banner placement {{…}}; no banner on the settings screen, over the keyboard, or in short windows. Load rewarded ads only when the upgrade screen opens, and grant the reward only after the ad is dismissed. Ad IDs come from build config and default to test IDs.
- Purchases: {{StoreKit 2 / Play Billing}}; refresh entitlements at launch and when returning to the foreground; a restore purchases entry point; local test configuration (.storekit / license testing); a debug switch that forces a tier.
- Put the red lines in CLAUDE.md. Screenshot and review both the Free and Pro tiers yourself.

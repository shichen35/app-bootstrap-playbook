# Release checklist

## Accounts and identifiers
- [ ] Developer team and signing configured; bundle ID / package name registered
- [ ] App Group, iCloud, Push and any other capabilities enabled in the account (identically for the app and its extensions)
- [ ] Version number and build number set

## Monetization
- [ ] Real ad IDs replace the test IDs (App ID, banner, rewarded); Release build confirmed not to use test IDs
- [ ] Consent flow (UMP) works under EEA, UK and US privacy-state test geographies
- [ ] In-app products created in the store console (IDs match the code), with prices, regions and review screenshots
- [ ] Purchase, restore, refund / revocation, and downgrade at trial expiry all tested in the sandbox

## Privacy and compliance
- [ ] Privacy policy URL in both the in-app settings page and the store listing
- [ ] iOS privacy manifest (PrivacyInfo.xcprivacy) / Play Data safety form
- [ ] Permission rationale text (local network, notifications, etc.) in English and Simplified Chinese
- [ ] The copy states clearly what data is not collected or uploaded

## Store assets
- [ ] Screenshots batch-generated with debug launch arguments (every size, English and Simplified Chinese, light and dark)
- [ ] Description leads with differentiators (taken from the competitor analysis) and makes no claims based on "Not verified" comparisons
- [ ] Keywords, category, age rating

## Quality
- [ ] `tools/check.sh` passes; core flows tested by hand on a real device with a Release build
- [ ] A human has signed off every item on the decision log's "not verified" list
- [ ] CHANGELOG / release notes

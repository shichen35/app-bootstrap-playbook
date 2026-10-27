# 12 · GitHub integration and release prep

For creating the repo, pushing, normalizing commit timestamps, and adding CI and Dependabot, see the [app-repo-publish](../skills/app-repo-publish/SKILL.md) Skill.

## Why private by default, and why push only main

Before launch, a repo usually still contains things that haven't been swapped out yet: test ad IDs, placeholder package names, demo data in screenshots. Keep it private, and decide whether to open it up only after the release checklist is done. Backup branches (such as `backup/before-redate`, taken before rewriting commit dates) are local insurance and never get pushed.

## Why commit dates can only be rewritten before the first push

Rewriting dates changes every commit hash. Do it after pushing and everyone else's clones stop matching the remote. Taking a backup branch first and confirming afterward that the content is unchanged is what makes this step safe.

## Repo extras the Skill doesn't cover

- `release.yml`: build and publish when a tag is pushed.
- `CHANGELOG.md`, `CONTRIBUTING.md`, `SECURITY.md`, `LICENSE` (if open source).
- Add "builds and tests pass with no warnings; CHANGELOG updated" to the checklist in the PR template.

## What the README must include

- One paragraph on what the app is and how the platform versions relate.
- A feature list (mapped to FRs).
- Build and check commands.
- **What to change before store submission**: developer team, App Group / bundle ID registration, real ad IDs, store products, privacy policy link.
- A directory table, one row per directory.

## Release checklist

See [app-repo-publish/RELEASE-CHECKLIST.md](../skills/app-repo-publish/RELEASE-CHECKLIST.md): signing, privacy manifest and Data safety, store assets (screenshots batch-generated with the debug hooks), pricing and regions, privacy policy URL, ad IDs and the consent flow, in-app product review, version numbers, and hands-on testing of the Release build.

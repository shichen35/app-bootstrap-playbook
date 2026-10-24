# 12 · GitHub integration and release prep

## Create the repo and push

```bash
gh auth status
gh repo create <owner>/<repo> --private --source . --remote origin --push
gh repo view <owner>/<repo> --json visibility,url,defaultBranchRef
```

Before pushing, check: no secrets (`local.properties`, real ad IDs and signing files are in `.gitignore`); no real user environment details in screenshots; backup branches stay local.

## Tidying commit history (optional)

If you need consistent commit timestamps (e.g. all during daytime hours on certain days, evenly spaced with random jitter), generate a mapping with [tools/common/redate-commits.py](../tools/common/redate-commits.py), then run `git filter-branch --env-filter` to rewrite both author and committer dates. Create a `backup/before-redate` branch first, and afterward confirm with `git diff backup/before-redate main --stat` that the content is unchanged. **Only do this before pushing**; never rewrite history that has already been pushed.

## Repo extras

- `.github/dependabot.yml`: daily Gradle / Swift Package dependency checks.
- `.github/workflows/ci.yml`: build + unit tests on push and PR, with caches keyed on toolchain version and lockfile; `release.yml` builds and publishes when a tag is pushed.
- `.github/ISSUE_TEMPLATE/` (bug / feature), `PULL_REQUEST_TEMPLATE.md` (what changed, how it was tested, and a checklist: builds and tests pass with no warnings; CHANGELOG updated).
- `CHANGELOG.md`, `CONTRIBUTING.md`, `SECURITY.md`, `LICENSE` (if open source).

## What the README must include

- One paragraph on what the app is and how the three platform versions relate.
- A feature list (mapped to FRs).
- Build and check commands.
- **What to change before store submission**: developer team, App Group / bundle ID registration, real ad IDs, store products, privacy policy link.
- A directory table, one row per directory.

## Release checklist

See [templates/release-checklist.md](../templates/release-checklist.md): signing, privacy manifest and Data safety, store assets (screenshots batch-generated with the debug hooks), pricing and regions, privacy policy URL, ad IDs and the consent flow, in-app product review, version numbers, and hands-on testing of the Release build.

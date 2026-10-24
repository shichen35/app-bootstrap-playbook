---
name: app-repo-publish
description: Publish a local app repository to GitHub as a private repo with gh, optionally normalize commit dates before the first push, and add Dependabot, CI, issue/PR templates, README "before release" section and a release checklist. Use for "create a GitHub repo and push", "create a private repo with gh", "normalize commit dates", "add CI / dependabot", or phase 12 of app-bootstrap.
---

# GitHub and release prep

Process: `<playbook>/process/12-github-and-release.md`. Script: `tools/common/redate-commits.py`. Template: `templates/release-checklist.md`.

## Pre-push checks

1. Make sure `git status` is clean and `.gitignore` covers build output, `local.properties`, signing files and DerivedData.
2. Scan for secrets and real IDs: `git grep -nE "ca-app-pub-[0-9]+[~/]|AIza|BEGIN (RSA|EC) PRIVATE"` (test ad IDs are fine).
3. Check that nothing in `doc/screenshots/` reveals the user's real environment.

## Normalize commit dates (only if the user asks, and only before the first push)

```bash
git branch backup/before-redate
python3 <playbook>/tools/common/redate-commits.py --date YYYY-MM-DD --start 09:00 --end 18:00 --tz -07:00 > /tmp/dates.txt
FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch -f --env-filter \
  'd=$(grep "^$GIT_COMMIT " /tmp/dates.txt | cut -d" " -f2); export GIT_AUTHOR_DATE="$d" GIT_COMMITTER_DATE="$d"' -- main
git diff backup/before-redate main --stat    # must be empty: only dates changed
rm -rf .git/refs/original
```

Never rewrite history that has already been pushed unless the user explicitly asks for it and understands the consequences.

## Create the repo and push

```bash
gh auth status
gh repo create <owner>/<name> --private --source . --remote origin --push
gh repo view <owner>/<name> --json visibility,url,defaultBranchRef
```

Push only `main`; keep the backup branch local.

## Extras (when the user wants them)

- `.github/dependabot.yml`: `gradle` or `swift` ecosystem, daily, with the user as assignee.
- `.github/workflows/ci.yml`: build and run unit tests on pushes to main and on PRs; include the toolchain version and the lockfile in the cache key.
- `.github/ISSUE_TEMPLATE/` and `PULL_REQUEST_TEMPLATE.md` (what changed, how it was tested, checklist).
- A "Before release" section in the README; copy the template to `doc/release-checklist.md`.

## Reply to the user

Give the repo URL (the full owner/repo link), which branches you pushed, what you left unpushed (the backup branch), and whether date normalization changed the commit hashes.

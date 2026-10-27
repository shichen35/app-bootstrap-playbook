## What it does

Publishes a local repo as a private GitHub repo. It runs a redaction check first (secrets, real ad IDs, personal information in screenshots), optionally rewrites commit dates before the first push, then creates the repo and pushes, and optionally adds CI, Dependabot and a release checklist.

## When to reach for it

Only you can trigger it, by typing `/app-repo-publish`, because pushing publishes your code outside your machine. Use it when a project goes to GitHub for the first time.

## Common questions

**Does rewriting commit dates change the commit hashes?**
Yes, which is why it only happens before the first push. It leaves a local backup branch first, then confirms that nothing but the dates changed.

**Does it push the backup branch?**
No. It pushes only `main`.

## It's working if

- The reply includes the full repo URL, and `visibility` is `PRIVATE`.
- The secret scan output is pasted in the reply, and it matched only test IDs, or nothing at all.

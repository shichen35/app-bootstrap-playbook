Publish {{repo path}} to GitHub:

1. {{optional}} Before pushing, change every commit date to {{YYYY-MM-DD}}, spread evenly across daytime hours in {{time zone}} with random jitter, rewriting both author and committer dates and keeping the order. Create a backup/before-redate branch first, and afterwards confirm the content is unchanged.
2. Create the private repo {{owner}}/{{name}} with gh and push only main.
3. {{optional}} Add .github/dependabot.yml ({{gradle / swift}}, daily), CI (build + unit tests on push / PR) and issue / PR templates; add a "Change before release" section to the README.

Before pushing, confirm there are no secrets, no real ad IDs, and no screenshots that show personal environment details.

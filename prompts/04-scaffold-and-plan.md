Set up the project scaffold and write the task plan ({{platform}}):

1. Project: {{Android: follow the layout, version catalog and build rules of {{reference project}} / iOS: a hand-written pbxproj with folder-synchronized groups, pure logic in a local Swift Package, App + widget targets, Info.plist fragments in Config/}}. Minimum OS {{version}}; package name / Bundle ID {{…}}.
2. CLAUDE.md: a one-sentence description, Commands, Hard rules (every ADR red line, plus commit, localization and simulator rules), and a Where to look table.
3. tools/check.sh: lint + unit tests + build (any warning in this repo's source fails it) + localization completeness. Copy it from tools/{{ios|android}}/ in the playbook and rename.
4. doc/dev-progress.md: 15–35 tasks, one commit each, tagged with FR numbers, milestones marked ★, with the resume protocol at the top.
5. doc/decisions.md: log the decisions and problems from the scaffold stage.
6. Once the check passes on the empty project, make two commits: `docs: …` and `build: …`.

# Development progress

One commit per task (Conventional Commits, single line). `tools/check.sh` must pass before every commit (check the exit code, not the last line of piped output), and the matching item here is ticked in the same commit. To resume after an interruption, pick up at the first unticked task: check `git log --oneline` and `git status` first, and finish any uncommitted changes and get them through the checks before committing. ★ marks a milestone: take screenshots in the simulator, review them, and write the findings into [decisions.md](decisions.md).

- [ ] 1. docs: requirements, architecture, ADRs, task plan, decision log
- [ ] 2. build: project scaffold, CLAUDE.md, tools/check.sh
- [ ] 3. feat(core): {{parsing}} (FR-…)
- [ ] 4. feat(core): {{state, statistics, history}}
- [ ] 5. feat(core): {{engine}}
- [ ] 6. feat(core): {{reports, templates, rules}}
- [ ] 7. feat({{platform}}): {{platform implementation}}
- [ ] 8. feat(data): settings and storage
- [ ] 9. feat(app): command entry point, foreground / background
- [ ] 10. feat({{main}}): main screen (FR-…) ★
- [ ] 11. feat(add): add and preview
- [ ] 12. feat({{main}}): edit, delete with undo, multi-select, actions
- [ ] 13. feat(detail): detail screen ★
- [ ] 14. feat(settings): settings
- [ ] 15. feat(reminders): reminders and notifications
- [ ] 16. feat(export): export, logs
- [ ] 17. feat(background): background work
- [ ] 18. feat(ui): wide screen / tablet ★
- [ ] 19. feat(widget): widgets
- [ ] 20. feat(store): one-time purchase, restore, limits, upgrade screen ★
- [ ] 21. feat(ads): banner and consent
- [ ] 22. feat(ads): rewarded trial
- [ ] 23. docs: README, test notes, wrap-up ★

## Backlog

Not in the numbered list above yet; move items into it when they are scheduled.

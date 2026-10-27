Using {{requirements doc path}} and {{existing implementation path}} as references, build a complete {{platform}} version of {{APP_NAME}}: match the features of {{reference platform}} or provide a platform-appropriate alternative, and follow {{platform}}'s latest UI framework, design guidelines ({{Liquid Glass / Material 3 Expressive}}) and best practices.

Requirements:
- Start with the architecture design and task plan (doc/architecture.md, doc/dev-progress.md), then build one task per commit. Run tools/check.sh (lint + tests + build + localization) before every commit; it must exit 0.
- At milestones, screenshot the app in the simulator yourself, review it, and fix problems on the spot.
- Keep working in this session until the app is finished. A session limit may interrupt you, so first set a scheduled wake-up every 3 hours: check whether the project is finished, and if not, continue from the first unticked item in the task list (use RESUME.md in the app-task-loop skill as the prompt). Delete the scheduled task once everything is done.
- Log every decision and problem along the way in doc/decisions.md (one file), and have me review it at the end. The last section lists what needs my decision, what was not done, and what was not verified.
- Tell me before downloading large files (simulator runtimes, SDKs). Do not create a remote repo and do not push.

Build an app from scratch following the app-bootstrap process ({{playbook path}}):

- Idea: {{one sentence: what it does}}
- Target users: {{who they are and what they use today}}
- References: {{similar products / path to the existing repo for another platform; "none" if there are none}}
- Platforms: {{Android (Kotlin, Compose, Material 3 Expressive) / iOS (SwiftUI, iOS 26+, Liquid Glass) / macOS}}
- Monetization: {{free / Pro as a one-time purchase / subscription / banner ads / rewarded trial}}
- Red lines: {{things it must never do, e.g. no uploading user data, no locking existing content on downgrade, no social features}}
- Language: UI in English and Simplified Chinese; docs in English; code comments in English and only say why.

Requirements:
1. Research first (competitor dossiers + comparison + pricing), then write the requirements (FR-numbered), the glossary, the architecture (tech-spec + ADRs + performance research) and an HTML mock. Stop at the end of each stage, show me the result, and list the points that need my decision. Move on only after I sign off.
2. Then build the scaffold (CLAUDE.md, tools/check.sh, dev-progress.md, decisions.md) and work through the task list one task per commit (single-line Conventional Commit). The check must pass before every commit, and at milestones you screenshot the app in the simulator and review it yourself.
3. Log every decision and every problem you hit in doc/decisions.md, and hand me a list of the checks you could not do.
4. Ask me before downloading large files, creating a remote repo, pushing, or buying anything.

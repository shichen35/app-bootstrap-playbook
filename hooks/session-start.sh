#!/bin/sh
# SessionStart: in a project with doc/dev-progress.md, tells the agent where the task list stands,
# so a resumed, cleared or compacted session picks up at the first unchecked task.
input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null)
[ -n "$cwd" ] && { cd "$cwd" 2>/dev/null || exit 0; }
root=$(git rev-parse --show-toplevel 2>/dev/null) || root=$PWD
file="$root/doc/dev-progress.md"
[ -f "$file" ] || exit 0

done_count=$(grep -cE '^[[:space:]]*[-*] \[[xX]\]' "$file")
todo_count=$(grep -cE '^[[:space:]]*[-*] \[ \]' "$file")
[ "$todo_count" -eq 0 ] && exit 0
next=$(grep -m 1 -E '^[[:space:]]*[-*] \[ \]' "$file" | sed -E 's/^[[:space:]]*[-*] \[ \][[:space:]]*//')

echo "doc/dev-progress.md: $done_count done, $todo_count to go. Next task: $next"
echo "Before starting it, check git status for uncommitted work from an earlier session (app-task-loop)."

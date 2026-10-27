#!/bin/sh
# PreToolUse(Bash): refuses `git commit` in a playbook project (one with tools/check-stamp.sh) unless
# tools/check.sh passed on the current working tree. Any other repo or command passes through.
# Needs jq; without it the gate stays open.
command -v jq >/dev/null || exit 0
input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty')

printf '%s\n' "$cmd" | grep -Eq '(^|[;&|(]|[[:space:]])git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+commit([[:space:]]|$)' || exit 0

[ -n "$cwd" ] && { cd "$cwd" 2>/dev/null || exit 0; }
dir=$(printf '%s\n' "$cmd" | sed -nE 's/.*git[[:space:]]+-C[[:space:]]+([^[:space:]]+)[[:space:]]+commit.*/\1/p' | head -n 1)
[ -n "$dir" ] && { cd "$dir" 2>/dev/null || exit 0; }
root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
[ -x "$root/tools/check-stamp.sh" ] || exit 0

"$root/tools/check-stamp.sh" verify && exit 0
echo "Commit blocked: tools/check.sh has not passed on the code as it is now. Run it on its own, read its exit code, fix what fails, then commit. Markdown edits after a passing check are fine." >&2
exit 2

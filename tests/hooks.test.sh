#!/bin/sh
# Runs the plugin hooks against throwaway git repos. Usage: tests/hooks.test.sh
set -u
repo_root=$(cd "$(dirname "$0")/.." && pwd)
gate="$repo_root/hooks/commit-gate.sh"
start="$repo_root/hooks/session-start.sh"
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
failures=0

# Prints the hook's exit code for a Bash command run in a directory.
run_gate() {
    jq -n --arg c "$2" --arg d "$1" '{tool_name: "Bash", tool_input: {command: $c}, cwd: $d}' |
        sh "$gate" 2>/dev/null
    echo $?
}

expect() {
    if [ "$2" = "$3" ]; then
        echo "ok   $1"
    else
        echo "FAIL $1: expected $2, got $3"
        failures=$((failures + 1))
    fi
}

# A playbook project whose check fails while a file named `broken` exists.
app="$work/app"
mkdir -p "$app/tools" "$app/doc" "$app/src"
cp "$repo_root/skills/app-scaffold/scripts/common/check-stamp.sh" "$app/tools/"
cat >"$app/tools/check.sh" <<'SH'
#!/bin/sh
set -e
cd "$(dirname "$0")/.."
[ ! -e src/broken ]
tools/check-stamp.sh write
SH
chmod +x "$app/tools/check.sh"
printf -- '- [x] 1. build: skeleton\n- [ ] 2. feat(core): parser\n- [ ] 3. feat(ui): list ★\n' >"$app/doc/dev-progress.md"
echo 'fun main() {}' >"$app/src/main.kt"
git -C "$app" init -q
git -C "$app" -c user.name=t -c user.email=t@t commit -q --allow-empty -m init

expect "commit without a check is blocked" 2 "$(run_gate "$app" 'git commit -m "feat: x"')"
"$app/tools/check.sh"
expect "commit after a passing check goes through" 0 "$(run_gate "$app" 'git add -A && git commit -m "feat: x"')"
echo '// more' >>"$app/src/main.kt"
expect "code edited after the check is blocked" 2 "$(run_gate "$app" 'git commit -m "feat: x"')"
"$app/tools/check.sh"
echo '- note' >>"$app/doc/decisions.md"
sed -i '' 's/- \[ \] 2/- [x] 2/' "$app/doc/dev-progress.md" 2>/dev/null || sed -i 's/- \[ \] 2/- [x] 2/' "$app/doc/dev-progress.md"
expect "Markdown edited after the check still commits" 0 "$(run_gate "$app" 'git commit -m "feat: x"')"
touch "$app/src/broken"
"$app/tools/check.sh" 2>/dev/null
expect "a failing check leaves the commit blocked" 2 "$(run_gate "$app" 'git commit -m "feat: x"')"
rm "$app/src/broken"
echo '// edit' >>"$app/src/main.kt"
expect "git -C from another directory is gated" 2 "$(run_gate "$work" "git -C $app commit -m x")"
expect "other git commands pass" 0 "$(run_gate "$app" 'git status && git log --oneline')"

other="$work/other"
mkdir -p "$other" && git -C "$other" init -q
expect "repos without check-stamp pass" 0 "$(run_gate "$other" 'git commit -m x')"

out=$(jq -n --arg d "$app/src" '{cwd: $d}' | sh "$start")
expect "session start names the next task" "doc/dev-progress.md: 2 done, 1 to go. Next task: 3. feat(ui): list ★" "$(echo "$out" | head -n 1)"
out=$(jq -n --arg d "$other" '{cwd: $d}' | sh "$start")
expect "session start is silent without a task list" "" "$out"

[ "$failures" -eq 0 ] && echo "all passed" || { echo "$failures failed"; exit 1; }

#!/bin/sh
# Records that tools/check.sh passed on the current working tree, and tells whether that record
# still matches. check.sh runs `write` as its last step; the playbook's commit-gate hook runs
# `verify` before every `git commit`. Markdown is left out of the fingerprint, so ticking the task
# list or writing the decision log after the check does not invalidate it.
# Usage: tools/check-stamp.sh write | verify
set -eu
cd "$(git rev-parse --show-toplevel)"
stamp="$(git rev-parse --git-dir)/check-stamp"

# Tree hash of every tracked and untracked, non-ignored file except Markdown, built in a scratch
# index so the real one is untouched.
fingerprint() {
    index=$(mktemp)
    cp "$(git rev-parse --git-dir)/index" "$index" 2>/dev/null || rm -f "$index"
    GIT_INDEX_FILE=$index git add -A
    GIT_INDEX_FILE=$index git rm -q -r --cached --ignore-unmatch -- '*.md'
    GIT_INDEX_FILE=$index git write-tree
    rm -f "$index"
}

case "${1:-}" in
write) fingerprint >"$stamp" ;;
verify) [ -f "$stamp" ] && [ "$(cat "$stamp")" = "$(fingerprint)" ] ;;
*)
    echo "usage: $0 write|verify" >&2
    exit 64
    ;;
esac

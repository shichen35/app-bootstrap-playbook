#!/usr/bin/env bash
# Links every skill in this repo into the local skill directories as symlinks, so a `git pull`
# updates the installed skills:
#   ~/.claude/skills  Claude Code
#   ~/.agents/skills  Codex and other Agent Skills-compatible harnesses
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DESTS=("$HOME/.claude/skills" "$HOME/.agents/skills")

for DEST in "${DESTS[@]}"; do
  # A destination that is itself a symlink into this repo would make us write links into skills/.
  if [ -L "$DEST" ]; then
    case "$(readlink -f "$DEST")" in
      "$REPO" | "$REPO"/*)
        echo "error: $DEST is a symlink into this repo; remove it and re-run." >&2
        exit 1
        ;;
    esac
  fi
  mkdir -p "$DEST"

  while IFS= read -r -d '' skill_md; do
    src="$(dirname "$skill_md")"
    target="$DEST/$(basename "$src")"
    # Never replace a real directory: it is someone's own skill with the same name.
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "skip $target: exists and is not a symlink" >&2
      continue
    fi
    ln -sfn "$src" "$target"
    echo "linked $(basename "$src") -> $src ($DEST)"
  done < <(find "$REPO/skills" -name SKILL.md -print0)
done

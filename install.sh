#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

link_items() {
  local src_dir="$1"
  local dest_dir="$2"

  mkdir -p "$dest_dir"

  for item in "$src_dir"/*; do
    [ -e "$item" ] || continue
    local name="$(basename "$item")"
    local target="$dest_dir/$name"

    if [ -L "$target" ]; then
      rm "$target"
    elif [ -e "$target" ]; then
      echo "  SKIP $name (exists and is not a symlink — back it up manually if needed)"
      continue
    fi

    ln -s "$item" "$target"
    echo "  $name -> $item"
  done
}

echo "Linking skills..."
link_items "$REPO_DIR/skills" "$CLAUDE_DIR/skills"

echo ""
echo "Linking commands..."
link_items "$REPO_DIR/commands" "$CLAUDE_DIR/commands"

echo ""
echo "Done. Verify with: ls -la ~/.claude/skills/ ~/.claude/commands/"

#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="clarify-first"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="$SCRIPT_DIR/$SKILL_NAME"

usage() {
  cat << 'USAGE'
Usage: ./install.sh [target]

Targets:
  codex     Install to ~/.codex/skills/
  claude    Install to ~/.claude/skills/
  opencode  Generate/append AGENTS.md for project root
  pi        Copy to current project (manual placement)
  all       Install to all detected platforms

If no target specified, auto-detects available platforms.
USAGE
}

install_codex() {
  local dest="$HOME/.codex/skills/$SKILL_NAME"
  mkdir -p "$dest"
  cp -r "$SKILL_SRC/" "$dest/"
  echo "✓ Installed to $dest"
}

install_claude() {
  local dest="$HOME/.claude/skills/$SKILL_NAME"
  mkdir -p "$dest"
  cp -r "$SKILL_SRC/" "$dest/"
  echo "✓ Installed to $dest"
}

install_opencode() {
  local agents_md="${1:-./AGENTS.md}"
  local content
  content=$(cat "$SKILL_SRC/SKILL.md")
  if [ -f "$agents_md" ] && grep -q "clarify-first" "$agents_md"; then
    echo "→ Already present in $agents_md, skipping."
  elif [ -f "$agents_md" ]; then
    printf "\n---\n\n%s\n" "$content" >> "$agents_md"
    echo "✓ Appended skill content to $agents_md"
  else
    printf "%s\n" "$content" > "$agents_md"
    echo "✓ Created $agents_md"
  fi
}

install_pi() {
  cp -r "$SKILL_SRC" "./$SKILL_NAME"
  echo "✓ Copied to ./$SKILL_NAME"
  echo "  Place according to your Pi agent's skill/rules directory."
}

detect_and_install_all() {
  local installed=0
  if [ -d "$HOME/.codex" ]; then install_codex; installed=1; fi
  if [ -d "$HOME/.claude" ]; then install_claude; installed=1; fi
  if [ -d ".opencode" ] || [ -f "AGENTS.md" ]; then install_opencode; installed=1; fi
  if [ "$installed" -eq 0 ]; then
    echo "No supported platform detected. Use: ./install.sh <target>"
    usage
    exit 1
  fi
}

case "${1:-}" in
  codex)    install_codex ;;
  claude)   install_claude ;;
  opencode) install_opencode ;;
  pi)       install_pi ;;
  all)      detect_and_install_all ;;
  "")       detect_and_install_all ;;
  *)        usage; exit 1 ;;
esac

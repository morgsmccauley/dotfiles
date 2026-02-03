#!/bin/bash
INPUT=$(cat)
MSG=$(echo "$INPUT" | jq -r '.message')
CWD=$(echo "$INPUT" | jq -r '.cwd')

REPO=$(cd "$CWD" && basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null)
if [ -z "$REPO" ]; then
  REPO=$(basename "$CWD")
fi

if [ -n "$NVIM" ]; then
  nvim --server "$NVIM" --remote-expr "luaeval('require(\"multiplexer\").set_metadata(_A)', {['claude']='waiting'})"
fi

osascript -e "display notification \"$MSG\" with title \"Claude Code ($REPO)\""

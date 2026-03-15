#!/bin/bash
set -euo pipefail

if [ -z "${NVIM:-}" ]; then
  exit 0
fi

if [ "$#" -lt 1 ]; then
  exit 0
fi

TYPE=$(printf "%s" "$1" | jq -r '.type // empty')
if [ "$TYPE" != "agent-turn-complete" ]; then
  exit 0
fi

nvim --server "$NVIM" --remote-expr "execute('checktime')" >/dev/null

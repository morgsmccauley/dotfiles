#!/bin/bash
set -euo pipefail

if [ -z "${NVIM:-}" ]; then
  exit 0
fi

cat >/dev/null
nvim --server "$NVIM" --remote-expr "execute('checktime')" >/dev/null

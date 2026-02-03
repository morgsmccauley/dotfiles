#!/bin/bash
if [ -n "$NVIM" ]; then
  nvim --server "$NVIM" --remote-expr "luaeval('require(\"multiplexer\").delete_metadata(_A)', 'claude')"
fi

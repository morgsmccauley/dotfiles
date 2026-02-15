#!/bin/bash
# Read JSON input from stdin
input=$(cat)

# Extract values using jq
MODEL_DISPLAY=$(echo "$input" | jq -r '.model.id')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd')
CTX=$(echo "$input" | jq -r '.context_window.used_percentage // "?"')

echo "[$MODEL_DISPLAY] | ${CURRENT_DIR##*/} | ${COST} | ctx:${CTX}%"

#!/bin/bash
# Read JSON input from stdin
input=$(cat)

# Extract values using jq
MODEL_DISPLAY=$(echo "$input" | jq -r '.model.id')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir')
SESSION_ID=$(echo "$input" | jq -r '.session_id')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd')

echo "[$MODEL_DISPLAY] | ${CURRENT_DIR##*/} | ${COST} | ${SESSION_ID}"

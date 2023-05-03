#!/bin/bash

# Define a function to fetch and format the tmuxinator and tmux data
generate_table() {
  printf "%-30s %-15s\n" "Project" "Status"

  tmuxinator_projects=$(tmuxinator list -n | tail -n +2)
  tmux_sessions=$(tmux list-sessions -F '#{session_name}')

  for project in $tmuxinator_projects; do
    if echo "$tmux_sessions" | grep -q "^$project$"; then
      status="Running"
    else
      status="Stopped"
    fi
    printf "%-30s %-15s\n" "$project" "$status"
  done
}

# Generate the table and pipe it into fzf with the specified options
generate_table | \
  fzf --header-lines=1 --bind='enter:execute(tmuxinator start {1})+abort,ctrl-x:execute(tmuxinator stop {1})'

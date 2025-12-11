#!/bin/bash

# File sync daemon: watches for changes and rsyncs only changed directories
# Uses fswatch for monitoring, rsync for transfer, SSH multiplexing for speed

set -u

REMOTE_HOST="${REMOTE_HOST:?REMOTE_HOST required}"
REMOTE_PATH="${REMOTE_PATH:?REMOTE_PATH required}"
EXCLUDE_FILE="${EXCLUDE_FILE:-}"
LATENCY="${LATENCY:-0.5}"

SSH_OPTS="-o ControlMaster=auto -o ControlPath=~/.ssh/cm-%r@%h:%p -o ControlPersist=10m -o ServerAliveInterval=60 -o ServerAliveCountMax=3"

log() { echo "$(date '+%H:%M:%S'): $1"; }

do_sync() {
  local dir="${1:-.}"
  local exclude_arg=""
  [[ -n "$EXCLUDE_FILE" ]] && exclude_arg="--exclude-from=$EXCLUDE_FILE"

  local relative="${dir#$PWD/}"
  [[ "$relative" == "$dir" ]] && relative="."

  if [[ "$relative" == "." ]]; then
    rsync -a --delete \
      --exclude='.git' --exclude='target' --exclude='node_modules' \
      --exclude='dist' --exclude='build' --exclude='*.swp' --exclude='*~' \
      $exclude_arg -e "ssh $SSH_OPTS" \
      ./ "$REMOTE_HOST:$REMOTE_PATH"
  else
    rsync -a --delete \
      --exclude='.git' --exclude='target' --exclude='node_modules' \
      --exclude='dist' --exclude='build' --exclude='*.swp' --exclude='*~' \
      $exclude_arg -e "ssh $SSH_OPTS" \
      "./$relative/" "$REMOTE_HOST:$REMOTE_PATH$relative/"
  fi
}

get_sync_dir() {
  local file="$1"
  local dir

  [[ -d "$file" ]] && dir="$file" || dir=$(dirname "$file")

  # If deleted, walk up to existing parent
  while [[ ! -d "$dir" ]] && [[ "$dir" != "." ]] && [[ "$dir" != "/" ]]; do
    dir=$(dirname "$dir")
  done

  echo "$dir"
}

log "Starting sync: . -> $REMOTE_HOST:$REMOTE_PATH"

log "Initial sync..."
do_sync && log "Initial sync complete" || log "Initial sync failed"

# Watch for changes and sync affected directories
/etc/profiles/per-user/morganmccauley/bin/fswatch --latency="$LATENCY" --recursive \
  --exclude='/target/' --exclude='/node_modules/' \
  --exclude='/dist/' --exclude='/build/' --exclude='~$' --exclude='\.swp$' \
  . | {
    while IFS= read -r file; do
      # Batch: collect this event + any more within 200ms
      dirs=("$(get_sync_dir "$file")")
      while IFS= read -r -t 1 file; do
        dirs+=("$(get_sync_dir "$file")")
      done

      # Dedupe directories
      unique_dirs=$(printf '%s\n' "${dirs[@]}" | sort -u)
      count=$(echo "$unique_dirs" | wc -l | tr -d ' ')

      if [[ $count -gt 5 ]]; then
        log "Many changes ($count dirs), full sync..."
        do_sync
      else
        for dir in $unique_dirs; do
          relative="${dir#$PWD/}"
          [[ "$relative" == "$dir" ]] && relative="."
          log "Syncing: $relative/"
          do_sync "$dir"
        done
      fi
      log "Done"
    done
  }

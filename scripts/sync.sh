#!/bin/bash

# Simple file sync daemon: watches for changes and rsyncs to remote
# Uses fswatch for monitoring, rsync for transfer, SSH multiplexing for speed

set -u

# Configuration (set via environment)
REMOTE_HOST="${REMOTE_HOST:?REMOTE_HOST required}"
REMOTE_PATH="${REMOTE_PATH:?REMOTE_PATH required}"
EXCLUDE_FILE="${EXCLUDE_FILE:-}"
DEBOUNCE="${DEBOUNCE:-1}"

# SSH multiplexing for persistent connections
SSH_OPTS="-o ControlMaster=auto -o ControlPath=~/.ssh/cm-%r@%h:%p -o ControlPersist=10m -o ServerAliveInterval=60 -o ServerAliveCountMax=3"

log() {
  echo "$(date '+%H:%M:%S'): $1"
}

do_full_sync() {
  local exclude_arg=""
  [[ -n "$EXCLUDE_FILE" ]] && exclude_arg="--exclude-from=$EXCLUDE_FILE"

  rsync -av --delete \
    --exclude='.git' --exclude='target' --exclude='node_modules' \
    --exclude='dist' --exclude='build' --exclude='*.swp' --exclude='*~' \
    $exclude_arg \
    -e "ssh $SSH_OPTS" \
    ./ "$REMOTE_HOST:$REMOTE_PATH"
}

do_file_sync() {
  local file="$1"
  local relative="${file#$PWD/}"

  # Skip if file doesn't exist (deleted) - return 2 to indicate no sync happened
  if [[ ! -e "$file" ]]; then
    log "File deleted, skipping: $relative"
    return 2
  fi

  rsync -av -e "ssh $SSH_OPTS" "$file" "$REMOTE_HOST:$REMOTE_PATH$relative"
}

log "Starting sync: . -> $REMOTE_HOST:$REMOTE_PATH"
log "Debounce: ${DEBOUNCE}s"

# Initial sync
log "Initial sync..."
if do_full_sync; then
  log "Initial sync complete"
else
  log "Initial sync failed, continuing anyway..."
fi

# Watch for changes and sync
/etc/profiles/per-user/morganmccauley/bin/fswatch --latency="$DEBOUNCE" --recursive \
  --exclude='/\.git/' --exclude='/target/' --exclude='/node_modules/' \
  --exclude='/dist/' --exclude='/build/' --exclude='~$' --exclude='\.swp$' \
  . | {
    last_sync=0
    while read -r file; do
      log "Change detected: $file"

      # Skip if we synced recently (within DEBOUNCE seconds)
      now=$(date +%s)
      if (( now - last_sync < DEBOUNCE )); then
        log "Skipping (synced $((now - last_sync))s ago)"
        continue
      fi

      do_file_sync "$file"
      rc=$?
      if (( rc == 0 )); then
        log "Sync complete"
        last_sync=$(date +%s)
      elif (( rc == 2 )); then
        : # Skipped, don't update last_sync
      else
        log "Sync failed (exit $rc)"
      fi
    done
  }

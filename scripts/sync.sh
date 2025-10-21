#!/bin/bash

# TODO for git changes, only sync relevant dir
# why are we seeing frequest git chagnes - maybe add debounce

# File sync daemon that watches for local changes and syncs them to a remote server
# Uses fswatch for file monitoring and rsync for efficient file transfer

# ========================================
# Configuration & Setup
# ========================================

# Logging function - timestamps all output with millisecond precision
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S.%3N'): $1"
}

# Debouncing configuration
LAST_SYNC=0                                    # Timestamp of last sync
DEBOUNCE_TIME=${DEBOUNCE_TIME:-0.1}           # Seconds to wait between syncs (reduced from 1s)
FSWATCH_LATENCY=${FSWATCH_LATENCY:-0.05}      # FSWatch event latency (reduced from 1s)

# Git change batching configuration
PENDING_GIT_SYNCS=""                          # Space-separated list to track pending git syncs by project path
GIT_BATCH_WINDOW=${GIT_BATCH_WINDOW:-2}       # Seconds to collect git changes before syncing
LAST_GIT_BATCH_FLUSH=0                        # Timestamp of last git batch flush

# Process monitoring configuration
MAX_BACKGROUND_JOBS=${MAX_BACKGROUND_JOBS:-50} # Maximum concurrent background syncs
SYNC_TIMEOUT=${SYNC_TIMEOUT:-30}              # Timeout warning threshold in seconds
LAST_HEALTH_CHECK=0                           # Timestamp of last health check
HEALTH_CHECK_INTERVAL=${HEALTH_CHECK_INTERVAL:-10} # Seconds between health checks

# Remote connection settings
REMOTE_HOST=${REMOTE_HOST}                     # Remote hostname
REMOTE_PATH=${REMOTE_PATH}                     # Remote directory path
EXCLUDE_FILE=${EXCLUDE_FILE}                   # Path to rsync exclude file

# SSH connection settings for multiplexing
SSH_OPTS="-o ControlMaster=auto -o ControlPath=~/.ssh/cm-%r@%h:%p -o ControlPersist=10m -o ServerAliveInterval=60 -o ServerAliveCountMax=3"

# Rsync options for full directory sync (used for git changes)
FULL_SYNC_OPTS="-a --no-compress --exclude-from=$EXCLUDE_FILE --inplace --whole-file --no-perms --no-group --no-times -e \"ssh $SSH_OPTS\""

# Rsync options for single file sync (used for individual file changes)
# Minimal flags: no compression, no checksums, just copy the file
SINGLE_FILE_OPTS="--no-compress --whole-file --inplace --no-perms --no-group --size-only -e \"ssh $SSH_OPTS\""

# ========================================
# Health Check Functions
# ========================================

# Check SSH control socket health
check_ssh_health() {
  local control_path="$HOME/.ssh/cm-ubuntu@$REMOTE_HOST:22"

  if [ -S "$control_path" ]; then
    # Control socket exists, check if it's alive
    if ssh -O check -o ControlPath="$control_path" $REMOTE_HOST 2>/dev/null; then
      log "SSH control socket HEALTHY: $control_path"
      return 0
    else
      log "SSH control socket EXISTS but DEAD: $control_path"
      return 1
    fi
  else
    log "SSH control socket NOT FOUND: $control_path (will be created on first connection)"
    return 0
  fi
}

# Count and log active background jobs
check_background_jobs() {
  local job_count=$(jobs -r | wc -l)

  if [ $job_count -gt $MAX_BACKGROUND_JOBS ]; then
    log "⚠️  WARNING: High background job count: $job_count (max: $MAX_BACKGROUND_JOBS)"
    log "⚠️  Possible SSH connection issues or slow syncs piling up"
  elif [ $job_count -gt 10 ]; then
    log "Active background jobs: $job_count"
  fi

  return $job_count
}

# Periodic health check
run_health_check() {
  local now=$(date +%s)

  if [ $((now - LAST_HEALTH_CHECK)) -gt $HEALTH_CHECK_INTERVAL ]; then
    log "=== HEALTH CHECK ==="
    check_background_jobs
    check_ssh_health
    log "===================="
    LAST_HEALTH_CHECK=$now
  fi
}

# ========================================
# Git Sync Functions
# ========================================

# Function to add a project to the pending git syncs
add_pending_git_sync() {
  local sync_path="$1"

  # Check if sync_path is already in the list (deduplication)
  if [[ " $PENDING_GIT_SYNCS " != *" $sync_path "* ]]; then
    PENDING_GIT_SYNCS="$PENDING_GIT_SYNCS $sync_path"
    log "Added to git batch: $sync_path (total pending: $(echo \"$PENDING_GIT_SYNCS\" | wc -w))"
  else
    log "Already in git batch, skipping: $sync_path"
  fi
}

# Function to flush all pending git syncs
flush_git_syncs() {
  if [ -z "$PENDING_GIT_SYNCS" ]; then
    return
  fi

  # Count the number of pending syncs
  local sync_count=$(echo "$PENDING_GIT_SYNCS" | wc -w)
  log ">>> Flushing $sync_count pending git syncs <<<"

  for sync_path in $PENDING_GIT_SYNCS; do
    log "Git batch sync START: $sync_path -> $REMOTE_HOST:$REMOTE_PATH"
    TIMEFORMAT="%3Rs"
    TIMING=$( (time eval "${RSYNC_BIN:-rsync} $FULL_SYNC_OPTS \"$sync_path\" $REMOTE_HOST:$REMOTE_PATH" 2>&1) 2>&1 )
    EXIT_CODE=$?
    if [ $EXIT_CODE -eq 0 ]; then
      log "Git batch sync SUCCESS: $sync_path ($TIMING)"
    else
      log "Git batch sync FAILED (exit $EXIT_CODE): $sync_path ($TIMING)"
    fi
  done

  # Clear the pending syncs
  PENDING_GIT_SYNCS=""
  LAST_GIT_BATCH_FLUSH=$(date +%s)
  log ">>> Git batch flush complete <<<"
}

# ========================================
# Main Sync Loop
# ========================================

log "========================================="
log "Starting file sync daemon"
log "Remote: $REMOTE_HOST:$REMOTE_PATH"
log "Debounce: ${DEBOUNCE_TIME}s, FSWatch latency: ${FSWATCH_LATENCY}s"
log "Git batch window: ${GIT_BATCH_WINDOW}s"
log "Max background jobs: $MAX_BACKGROUND_JOBS"
log "Sync timeout warning: ${SYNC_TIMEOUT}s"
log "Health check interval: ${HEALTH_CHECK_INTERVAL}s"
log "SSH options: $SSH_OPTS"
log "========================================="

# Initial health check
check_ssh_health

# Start fswatch to monitor file changes
# Use kqueue monitor on macOS for better performance
if [[ "$OSTYPE" == "darwin"* ]]; then
  # FSWATCH_MONITOR="-m kqueue_monitor"
  FSWATCH_MONITOR=""
else
  FSWATCH_MONITOR=""
fi

${FSWATCH_BIN:-fswatch} \
  $FSWATCH_MONITOR \
  --latency=$FSWATCH_LATENCY \
  --exclude='*/target/*' \
  --exclude='*/.git/*' \
  --exclude='*~$' \
  --exclude='*.swp' \
  --exclude='*.tmp' \
  . | while read file; do
    
    # Get current timestamp for debouncing
    NOW=$(date +%s)

    # Run periodic health check
    run_health_check

    # Convert absolute path to relative path for cleaner logging
    RELATIVE_FILE=$(echo "$file" | sed "s|$(pwd)/||")
    
    # ----------------------------------------
    # Handle Git Changes
    # ----------------------------------------
    # Git changes are batched to avoid redundant syncs
    if [[ "$RELATIVE_FILE" =~ \.git/ ]]; then
      log "Git change detected: $RELATIVE_FILE"
      # Extract the directory containing the git change
      CHANGED_DIR=$(dirname "$RELATIVE_FILE")

      # If it's a root .git file, sync the whole directory
      if [[ "$CHANGED_DIR" == ".git" ]]; then
        SYNC_PATH="."
        log "Root .git change, will sync entire directory"
      else
        # Find the project root (directory containing .git folder)
        PROJECT_ROOT=$(echo "$CHANGED_DIR" | sed 's|/.git.*||')
        SYNC_PATH="$PROJECT_ROOT"
        log "Project .git change in $PROJECT_ROOT"
      fi

      # Add to pending git syncs (deduplicates automatically)
      add_pending_git_sync "$SYNC_PATH"
      continue
    fi
    
    # ----------------------------------------
    # Flush Git Syncs if Batch Window Expired
    # ----------------------------------------
    # Check if it's time to flush pending git syncs
    if [ -n "$PENDING_GIT_SYNCS" ] && [ $((NOW - LAST_GIT_BATCH_FLUSH)) -gt $GIT_BATCH_WINDOW ]; then
      log "Git batch window expired (${GIT_BATCH_WINDOW}s), triggering flush"
      flush_git_syncs
    fi
    
    # ----------------------------------------
    # Skip Invalid Files
    # ----------------------------------------
    # Skip files that shouldn't be synced:
    # - Editor backup files (ending with ~)
    # - Temporary files (ending with 4 digits)
    # - Non-existent files (deleted between event and processing)
    if [[ "$RELATIVE_FILE" =~ \~$ ]] || [[ "$RELATIVE_FILE" =~ /[0-9]{4}$ ]] || [ ! -f "$RELATIVE_FILE" ]; then
      log "Skipping invalid/temp file: $RELATIVE_FILE"
      continue  # Skip without updating timer
    fi
    
    # Check if we have too many background jobs before spawning more
    CURRENT_JOBS=$(jobs -r | wc -l)
    if [ $CURRENT_JOBS -gt $MAX_BACKGROUND_JOBS ]; then
      log "⚠️  BLOCKING: Too many background jobs ($CURRENT_JOBS), waiting for some to complete..."
      wait -n  # Wait for at least one job to finish
    fi

    # Run sync in background for parallel processing
    (
      START_TIME=$(date +%s)
      log "File sync START: $RELATIVE_FILE (background job $$)"
      TIMEFORMAT="%3Rs"

      # For small files (<10MB), use tar streaming for better performance
      FILE_SIZE=$(stat -f%z "$RELATIVE_FILE" 2>/dev/null || stat -c%s "$RELATIVE_FILE" 2>/dev/null || echo "0")
      log "File size: $FILE_SIZE bytes for $RELATIVE_FILE"

      if [ "$FILE_SIZE" -lt 10485760 ] && [ "$FILE_SIZE" -gt 0 ]; then
        # Use tar streaming for small files (faster than rsync)
        log "Using tar streaming for: $RELATIVE_FILE"
        TIMING=$( (time tar cf - "$RELATIVE_FILE" 2>/dev/null | ssh $SSH_OPTS $REMOTE_HOST "cd $REMOTE_PATH && tar xf - 2>/dev/null") 2>&1 )
        EXIT_CODE=$?
      else
        # Use rsync for larger files or when size detection fails
        log "Using rsync for: $RELATIVE_FILE"
        TIMING=$( (time eval "${RSYNC_BIN:-rsync} $SINGLE_FILE_OPTS \"$RELATIVE_FILE\" $REMOTE_HOST:$REMOTE_PATH\"$RELATIVE_FILE\"" 2>&1) 2>&1 )
        EXIT_CODE=$?
      fi

      END_TIME=$(date +%s)
      DURATION=$((END_TIME - START_TIME))

      if [ $EXIT_CODE -eq 0 ]; then
        if [ $DURATION -gt $SYNC_TIMEOUT ]; then
          log "⚠️  File sync SUCCESS but SLOW (${DURATION}s > ${SYNC_TIMEOUT}s): $RELATIVE_FILE ($TIMING)"
        else
          log "File sync SUCCESS: $RELATIVE_FILE ($TIMING)"
        fi
      else
        log "❌ File sync FAILED (exit $EXIT_CODE, ${DURATION}s): $RELATIVE_FILE ($TIMING)"
      fi
    ) &
  done

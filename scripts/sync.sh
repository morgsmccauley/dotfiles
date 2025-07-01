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

# Remote connection settings
REMOTE_HOST=${REMOTE_HOST}                     # Remote hostname
REMOTE_PATH=${REMOTE_PATH}                     # Remote directory path
EXCLUDE_FILE=${EXCLUDE_FILE}                   # Path to rsync exclude file

# Rsync options for full directory sync (used for git changes)
FULL_SYNC_OPTS="-a --no-compress --exclude-from=$EXCLUDE_FILE --inplace --whole-file --no-perms --no-group --no-times"

# Rsync options for single file sync (used for individual file changes)
# Minimal flags: no compression, no checksums, just copy the file
SINGLE_FILE_OPTS="--no-compress --whole-file --inplace --no-perms --no-group --size-only"

# ========================================
# Git Sync Functions
# ========================================

# Function to add a project to the pending git syncs
add_pending_git_sync() {
  local sync_path="$1"
  
  # Check if sync_path is already in the list (deduplication)
  if [[ " $PENDING_GIT_SYNCS " != *" $sync_path "* ]]; then
    PENDING_GIT_SYNCS="$PENDING_GIT_SYNCS $sync_path"
    log "Added to git batch: $sync_path"
  fi
}

# Function to flush all pending git syncs
flush_git_syncs() {
  if [ -z "$PENDING_GIT_SYNCS" ]; then
    return
  fi
  
  # Count the number of pending syncs
  local sync_count=$(echo "$PENDING_GIT_SYNCS" | wc -w)
  log "Flushing $sync_count pending git syncs"
  
  for sync_path in $PENDING_GIT_SYNCS; do
    log "Git batch sync: $sync_path -> $REMOTE_HOST:$REMOTE_PATH"
    TIMEFORMAT="%3Rs"
    TIMING=$( (time ${RSYNC_BIN:-rsync} $FULL_SYNC_OPTS "$sync_path" $REMOTE_HOST:$REMOTE_PATH >/dev/null) 2>&1 )
    log "Git batch sync completed: $sync_path ($TIMING)"
  done
  
  # Clear the pending syncs
  PENDING_GIT_SYNCS=""
  LAST_GIT_BATCH_FLUSH=$(date +%s)
}

# ========================================
# Main Sync Loop
# ========================================

log "Starting file sync..."

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

    # Convert absolute path to relative path for cleaner logging
    RELATIVE_FILE=$(echo "$file" | sed "s|$(pwd)/||")
    
    # ----------------------------------------
    # Handle Git Changes
    # ----------------------------------------
    # Git changes are batched to avoid redundant syncs
    if [[ "$RELATIVE_FILE" =~ \.git/ ]]; then
      # Extract the directory containing the git change
      CHANGED_DIR=$(dirname "$RELATIVE_FILE")
      
      # If it's a root .git file, sync the whole directory
      if [[ "$CHANGED_DIR" == ".git" ]]; then
        SYNC_PATH="."
      else
        # Find the project root (directory containing .git folder)
        PROJECT_ROOT=$(echo "$CHANGED_DIR" | sed 's|/.git.*||')
        SYNC_PATH="$PROJECT_ROOT"
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
      continue  # Skip without updating timer
    fi
    
    # Run sync in background for parallel processing
    (
      # log "Syncing file: $RELATIVE_FILE"
      TIMEFORMAT="%3Rs"
      
      # For small files (<10MB), use tar streaming for better performance
      FILE_SIZE=$(stat -f%z "$RELATIVE_FILE" 2>/dev/null || stat -c%s "$RELATIVE_FILE" 2>/dev/null || echo "0")
      
      if [ "$FILE_SIZE" -lt 10485760 ] && [ "$FILE_SIZE" -gt 0 ]; then
        # Use tar streaming for small files (faster than rsync)
        TIMING=$( (time tar cf - "$RELATIVE_FILE" 2>/dev/null | ssh $SSH_OPTS $REMOTE_HOST "cd $REMOTE_PATH && tar xf - 2>/dev/null") 2>&1 )
      else
        # Use rsync for larger files or when size detection fails
        TIMING=$( (time ${RSYNC_BIN:-rsync} $SINGLE_FILE_OPTS "$RELATIVE_FILE" $REMOTE_HOST:$REMOTE_PATH"$RELATIVE_FILE" 2>&1) 2>&1 )
      fi
      
      log "Sync completed: $RELATIVE_FILE ($TIMING)"
    ) &
  done

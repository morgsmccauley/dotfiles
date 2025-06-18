#!/bin/bash

# File sync daemon that watches for local changes and syncs them to a remote server
# Uses fswatch for file monitoring and rsync for efficient file transfer

# ========================================
# Configuration & Setup
# ========================================

# Logging function - timestamps all output
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S'): $1"
}

# Debouncing configuration
LAST_SYNC=0                                    # Timestamp of last sync
DEBOUNCE_TIME=${DEBOUNCE_TIME:-1}             # Seconds to wait between syncs
FSWATCH_LATENCY=${FSWATCH_LATENCY:-1}         # FSWatch event latency

# Remote connection settings
REMOTE_HOST=${REMOTE_HOST}                     # Remote hostname
REMOTE_PATH=${REMOTE_PATH}                     # Remote directory path
EXCLUDE_FILE=${EXCLUDE_FILE}                   # Path to rsync exclude file

# Rsync options for full directory sync (used for git changes)
FULL_SYNC_OPTS="-az --compress-level=1 --exclude-from=$EXCLUDE_FILE --partial --inplace --whole-file"

# Rsync options for single file sync (used for individual file changes)
SINGLE_FILE_OPTS="-az"

# ========================================
# Main Sync Loop
# ========================================

log "Starting file sync..."

# Start fswatch to monitor file changes
${FSWATCH_BIN:-fswatch} \
  --latency=$FSWATCH_LATENCY \
  --exclude='*/target/*' \
  --exclude='*/.git/*' \
  --exclude='*~$' \
  . | while read file; do
    
    # Get current timestamp for debouncing
    NOW=$(date +%s)

    # Convert absolute path to relative path for cleaner logging
    RELATIVE_FILE=$(echo "$file" | sed "s|$(pwd)/||")
    
    # ----------------------------------------
    # Handle Git Changes
    # ----------------------------------------
    # Git changes require full directory sync to maintain consistency
    if [[ "$RELATIVE_FILE" =~ \.git/ ]]; then
      if [ $((NOW - LAST_SYNC)) -gt $DEBOUNCE_TIME ]; then
        log "Git change detected, syncing dir: $REMOTE_HOST:$REMOTE_PATH"
        TIMEFORMAT="%3Rs"
        TIMING=$( (time ${RSYNC_BIN:-rsync} $FULL_SYNC_OPTS . $REMOTE_HOST:$REMOTE_PATH >/dev/null) 2>&1 )
        log "Sync took: $TIMING"
        LAST_SYNC=$NOW
      fi
      continue
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
    
    # ----------------------------------------
    # Sync Individual Files
    # ----------------------------------------
    # Apply debouncing to prevent excessive syncs
    if [ $((NOW - LAST_SYNC)) -gt $DEBOUNCE_TIME ]; then
      log "Syncing file: $RELATIVE_FILE"
      TIMEFORMAT="%3Rs"
      
      # Sync the file to remote, preserving directory structure
      TIMING=$( (time ${RSYNC_BIN:-rsync} $SINGLE_FILE_OPTS "$RELATIVE_FILE" $REMOTE_HOST:$REMOTE_PATH"$RELATIVE_FILE" 2>&1) 2>&1 )
      log "Sync took: $TIMING"
      LAST_SYNC=$NOW
    fi
    # Files within debounce window are silently ignored
  done

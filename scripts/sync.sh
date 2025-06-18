#!/bin/bash

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
    # Limit concurrent jobs to prevent overwhelming the system
    while [ $(jobs -r | wc -l) -ge 4 ]; do
      sleep 0.01
    done
    
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

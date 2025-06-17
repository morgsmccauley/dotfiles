#!/bin/bash

# Logging function
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S'): $1"
}

# Configuration
LAST_SYNC=0
DEBOUNCE_TIME=${DEBOUNCE_TIME:-1}
FSWATCH_LATENCY=${FSWATCH_LATENCY:-1}
REMOTE_HOST=${REMOTE_HOST}
REMOTE_PATH=${REMOTE_PATH}
EXCLUDE_FILE=${EXCLUDE_FILE}

# Rsync options for full sync
FULL_SYNC_OPTS="-az --compress-level=1 --exclude-from=$EXCLUDE_FILE --partial --inplace --whole-file"

# Rsync options for single file sync
SINGLE_FILE_OPTS="--whole-file --inplace -t"

log "Starting file sync..."

${FSWATCH_BIN:-fswatch} \
  --latency=$FSWATCH_LATENCY \
  --exclude='*/target/*' \
  --exclude='*/.git/*' \
  --exclude='*~$' \
  . | while read file; do
    NOW=$(date +%s)

    # Convert absolute path to relative
    RELATIVE_FILE=$(echo "$file" | sed "s|$(pwd)/||")
    
    # Handle git changes - sync whole directory
    if [[ "$RELATIVE_FILE" =~ \.git/ ]]; then
      if [ $((NOW - LAST_SYNC)) -gt $DEBOUNCE_TIME ]; then
        log "Git change detected, syncing dir: $REMOTE_HOST:$REMOTE_PATH"
        TIMEFORMAT="%3Rs"
        TIMING=$( (time ${RSYNC_BIN:-rsync} $FULL_SYNC_OPTS . $REMOTE_HOST:$REMOTE_PATH >/dev/null) 2>&1 )
        log "Sync took: $TIMING"
        LAST_SYNC=$NOW
      # else
      #   log "Git change detected (debounced)"
      fi
      continue
    fi
    
    # Skip temp files and check if file exists
    if [[ "$RELATIVE_FILE" =~ \~$ ]] || [[ "$RELATIVE_FILE" =~ /[0-9]{4}$ ]] || [ ! -f "$RELATIVE_FILE" ]; then
      # Skip without updating timer
      continue
    fi
    
    if [ $((NOW - LAST_SYNC)) -gt $DEBOUNCE_TIME ]; then
      log "Syncing file: $RELATIVE_FILE"
      TIMEFORMAT="%3Rs"
      TIMING=$( (time ${RSYNC_BIN:-rsync} $SINGLE_FILE_OPTS "$RELATIVE_FILE" $REMOTE_HOST:$REMOTE_PATH"$RELATIVE_FILE" >/dev/null) 2>&1 )
      log "Sync took: $TIMING"
      LAST_SYNC=$NOW
    else
      RELATIVE_FILE=$(echo "$file" | sed "s|$(pwd)/||")
      # Only show debounce for files we'd actually sync
      # if [[ ! "$RELATIVE_FILE" =~ \~$ ]] && [[ ! "$RELATIVE_FILE" =~ /[0-9]{4}$ ]] && [[ ! "$RELATIVE_FILE" =~ \.git/ ]] && [ -f "$RELATIVE_FILE" ]; then
      #   log "File changed: $RELATIVE_FILE (debounced)"
      # fi
    fi
  done

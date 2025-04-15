#!/bin/bash

# Usage check
if [ $# -ne 2 ]
then
    echo "Usage: $0 <source_dir> <target_dir> [--real-run]"
    exit 1
fi

SRC="$1"
DST="$2"
MODE="$3"

DATE=$(date +%Y-%m-%d)
LOG_DIR="logs"
LOG_FILE="$LOG_DIR/backup_$DATE.log"
LOCK_FILE="/tmp/backup.lock"

if ! command -v rsync > /dev/null; then
    echo "rsync not found. Install it first."
    exit 2
fi

[ ! -d "$SRC" ] && echo "Source not found." && exit 3
[ ! -d "$DST" ] && echo "Target not found." && exit 4

[ -f "$LOCK_FILE" ] && echo "Backup in progress." && exit 5
trap "rm -f $LOCK_FILE" EXIT
touch "$LOCK_FILE"

mkdir -p "$LOG_DIR"

OPTS="-avb --backup-dir=$DST/$DATE --delete"
[ "$MODE" != "--real-run" ] && OPTS+=" --dry-run"

echo "Starting backup..."
rsync $OPTS "$SRC" "$DST/current" >> "$LOG_FILE" 2>&1
echo "Done. Log: $LOG_FILE"

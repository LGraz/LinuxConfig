#!/bin/bash
set -e

# Configuration
REPO="/media/lukas/BackupLG/restic-repo"
PASS_FILE="/home/lukas/.config/restic/sd_password"
EXCLUDES="/home/lukas/.config/restic/sd_excludes.txt"

# 1. Check if SD card is actually mounted/accessible
if ! mountpoint -q /media/lukas/BackupLG; then
    echo "SD Card not mounted. Attempting to access to trigger automount..."
    # Accessing the dir triggers systemd automount
    ls /media/lukas/BackupLG > /dev/null 2>&1
    sleep 2
fi

if ! [ -d "$REPO" ]; then
    notify-send "Restic: Backup Failed" "Repository not found on SD card."
    exit 1
fi

# 2. Export Restic Variables
export RESTIC_REPOSITORY="$REPO"
export RESTIC_PASSWORD_FILE="$PASS_FILE"

# 3. Run Backup
# --one-file-system prevents crossing into other mounts (like /proc if you were running as root, or other partitions)
# notify-send "Restic" "Starting Backup..."

if restic backup /home/lukas \
    --exclude-file="$EXCLUDES" \
    --one-file-system \
    --tag "sd-card-backup"; then
    
	# 4. Prune old snapshots
    # --keep-within 1d: Keeps ALL snapshots from the last 24h (preserves your 30-min intervals)
    # --keep-daily 10:  Keeps the last snapshot of the day for the last 10 days
    restic forget --prune \
        --keep-within 1d \
        --keep-daily 10 \
        --keep-weekly 4 \
        --keep-monthly 6 \
        --keep-yearly 1
        
    # notify-send "Restic" "Backup Successful"
else
    notify-send "Restic" "Backup Failed during execution"
    exit 1
fi

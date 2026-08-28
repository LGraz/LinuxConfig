#!/bin/bash
set -euo pipefail

# ---- single-instance guard --------------------------------------------------
# Prevents overlapping runs (a long prune + a 30-min timer = stacked runs,
# which is how abandoned exclusive locks happen in the first place).
exec 9>"${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/restic_sd_backup.lock"
if ! flock -n 9; then
    echo "Previous run still in progress, skipping."
    exit 0
fi

# ---- configuration ----------------------------------------------------------
MOUNT="/media/lukas/BackupLG"
REPO="$MOUNT/restic-repo"
PASS_FILE="/home/lukas/.config/restic/sd_password"
EXCLUDES="/home/lukas/.config/restic/sd_excludes.txt"
PRUNE_STAMP="/home/lukas/.cache/restic_sd_last_prune"
PRUNE_INTERVAL=$((24 * 3600))   # run forget --prune at most once a day

fail() {
    notify-send "Restic: Backup Failed" "$1" 2>/dev/null || true
    echo "ERROR: $1" >&2
    exit 1
}

# ---- 1. make sure the SD card is there --------------------------------------
if ! mountpoint -q "$MOUNT"; then
    echo "SD card not mounted, triggering automount..."
    ls "$MOUNT" >/dev/null 2>&1 || true
    sleep 2
fi
mountpoint -q "$MOUNT" || fail "SD card not mounted ($MOUNT)."
[ -d "$REPO" ]         || fail "Repository not found at $REPO."
[ -r "$PASS_FILE" ]    || fail "Password file not readable ($PASS_FILE)."
[ -r "$EXCLUDES" ]     || fail "Exclude file not readable ($EXCLUDES)."

# ---- 2. environment ---------------------------------------------------------
export RESTIC_REPOSITORY="$REPO"
export RESTIC_PASSWORD_FILE="$PASS_FILE"

# ---- 3. clear locks left behind by killed runs ------------------------------
# Only removes locks restic considers stale; a live run's lock is untouched.
restic unlock || fail "Could not clear stale locks. Run 'restic list locks' manually."

# ---- 4. backup --------------------------------------------------------------
restic backup /home/lukas \
    --exclude-file="$EXCLUDES" \
    --one-file-system \
    --exclude-caches \
    --tag "sd-card-backup" \
    || fail "Backup run failed."

# ---- 5. retention -----------------------------------------------------------
# forget (cheap, metadata only) every run; prune (expensive, exclusive lock)
# at most once every PRUNE_INTERVAL seconds.
now=$(date +%s)
last=0
[ -f "$PRUNE_STAMP" ] && last=$(cat "$PRUNE_STAMP" 2>/dev/null || echo 0)

KEEP=(--keep-within 1d --keep-daily 10 --keep-weekly 4 --keep-monthly 6 --keep-yearly 1)

if [ $((now - last)) -ge "$PRUNE_INTERVAL" ]; then
    echo "Running forget with prune..."
    if restic forget --prune "${KEEP[@]}"; then
        mkdir -p "$(dirname "$PRUNE_STAMP")"
        echo "$now" > "$PRUNE_STAMP"
    else
        notify-send "Restic" "Backup OK, but prune failed." 2>/dev/null || true
        exit 1
    fi
else
    echo "Running forget without prune (last prune $(( (now - last) / 3600 ))h ago)..."
    restic forget "${KEEP[@]}" \
        || notify-send "Restic" "Backup OK, but forget failed." 2>/dev/null || true
fi

exit 0

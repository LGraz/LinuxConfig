#! /bin/bash

### /etc/fstab 
# SD card
# /dev/mmcblk0p1 /media/hothorn/artemishome ext4 noauto,user 0 0
if ! [ -d /media/lukas/BackupLG/homebak ]; then
    mount /media/lukas/BackupLG/ || notify-send "Rsync: failed to mount /media/lukas/BackupLG/"
fi;

if [ -d /media/lukas/BackupLG/homebak ]; then
    rsync -avuz --delete --exclude-from="/home/lukas/Work/.tukey-bak-rsync-ignore" /home/lukas/ /media/lukas/BackupLG/homebak/ > /home/lukas/.rsync_home_backup.log 2>&1 || notify-send "Rsync: Backup Failed"
    umount /media/lukas/BackupLG/
else
    notify-send "Rsync: Backup Failed"
fi;

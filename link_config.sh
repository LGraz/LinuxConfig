#!/bin/bash

# Backup and update config files

CDIR="$HOME/LinuxConfig/config_files"
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
backup_dir="$HOME/.config/conf_backups/backup_$timestamp"
mkdir -p "$backup_dir"

# Backup and link configuration directories
for dir in "$CDIR/config_dirs"/*; do
    dir_name=$(basename "$dir")
    echo "Removing and linking the directory: $HOME/.config/$dir_name"
    mv "$HOME/.config/$dir_name" "$backup_dir"
    [ -e "$CDIR/config_dirs/$dir_name" ] && ln -rs "$CDIR/config_dirs/$dir_name" "$HOME/.config/"
done

# Backup and link configuration files
mkdir -p "$backup_dir/homedir"
for file in "$CDIR/homedir"/*; do
    file_name=$(basename "$file")
    echo "Removing and linking the file: $HOME/$file_name"
    mv "$HOME/$file_name" "$backup_dir/homedir"
    [ -e "$CDIR/homedir/$file_name" ] && ln -rs "$CDIR/homedir/$file_name" "$HOME/$file_name"
done

# Update crontabs
crontab "$HOME/.cronjobs"


# ln -s $CDIR/config_dirs/Code\ -\ OSS $HOME/.config

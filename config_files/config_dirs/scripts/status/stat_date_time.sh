#!/bin/sh
source $HOME/.config/scripts/status/i3block_click_toggle.sh

LCL=$HOME/.config/scripts/status/stat_date_time_left_click.lck
MCL=$HOME/.config/scripts/status/stat_date_time_middle_click.lck
RCL=$HOME/.config/scripts/status/stat_date_time_right_click.lck

check_click $LCL $MCL $RCL $BLOCK_BUTTON

#### DATE ####
date=" $(date '+%A %d %B %Y') "


#### TIME ####
time=" $(date '+%H:%M') "

if [[ -f "$LCL" ]]
then
    output="$date"
else
    output="$time"
fi

printf '{"full_text":"%s"\n}' "$output"

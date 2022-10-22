#!/bin/sh
#### Free RAM ####
source $HOME/.config/scripts/status/get_color.sh
source $HOME/.config/scripts/status/i3block_click_toggle.sh

LCL=$HOME/.config/scripts/status/stat_ram_left_click.lck
MCL=$HOME/.config/scripts/status/stat_ram_middle_click.lck
RCL=$HOME/.config/scripts/status/stat_ram_right_click.lck

check_click $LCL $MCL $RCL $BLOCK_BUTTON

TOTAL=$(free -h --si | awk -F" " '/Mem/{print $2}')
T=$(free | awk -F" " '/Mem/{print $2}')
USED=$(free -h --si | awk -F" " '/Mem/{print $3}')
FREE=$(free -h --si | awk -F" " '/Mem/{print $4}')
F=$(free | awk -F" " '/Mem/{print $4}')
CACHED=$(free -h --si | awk -F" " '/Mem/{print $6}')

ICON=""

F=$(echo "$F*100/$T" | bc -l)
COLOR=$(get_color $F)

if [[ -f $LCL ]]
then
    OUTPUT="[ $ICON Used: $USED  Cached: $CACHED  Free: $FREE  Total: $TOTAL ]"
    short="$ICON [ Used: $USED  Free: $FREE  Total: $TOTAL ]"

else
    OUTPUT=" $ICON $FREE "
fi

printf '{"full_text":"%s", "short_text":"%s", "color":"%s"\n}' "$OUTPUT" "$short" "$COLOR"


#!/bin/sh
source $HOME/.config/scripts/status/get_color.sh

#### BATTERY USAGE ####
STATUS=$(cat /sys/class/power_supply/BAT0/status)
LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)

COLOR=$(get_color $LEVEL)

if [[ $STATUS = "Charging" ]]
then
    POWER="  $LEVEL%"
    COLOR="#406080"
else
    POWER=" $LEVEL%"
fi


printf '{"full_text":"%s", "color":"%s"}\n' "$POWER" "$COLOR"

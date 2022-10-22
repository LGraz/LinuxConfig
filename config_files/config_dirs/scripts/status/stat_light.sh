#!/bin/bash
source $HOME/.config/scripts/status/get_color.sh
source $HOME/.config/scripts/status/i3block_click_toggle.sh

if [[ $BLOCK_BUTTON -eq 4 ]]
then
    light -U 1
elif [[ $BLOCK_BUTTON -eq 5 ]]
then
    light -A 1
fi

#### BRIGHTNESS ####
light=$(printf "%.0f" $(light -G))
color=$(get_color $light)
output="  $light% "
printf '{"full_text":"%s", "color":"%s"\n}' "$output" "$color"

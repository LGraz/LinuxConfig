#!/bin/bash
source $HOME/.config/scripts/status/get_color.sh

#### VOLUME ####
volume=$(pamixer --get-volume)

if ! [[ "$volume" =~ ^[0-9]+$ ]]
    then
        systemctl restart --user pipewire
    else
        color=$(get_color $volume)

        if [[ $BLOCK_BUTTON -eq 1 ]]
        then
            pamixer -t
        elif [[ $BLOCK_BUTTON -eq 4 ]]
        then
            pamixer -d 1
        elif [[ $BLOCK_BUTTON -eq 5 ]]
        then
            pamixer -i 1
        fi

        if [[ $(pamixer --get-mute) == "false" ]]
        then
            volume=" $volume%"
        else
            color="#802040"
            volume=" $volume%"
        fi

        printf '{"full_text":"%s", "color":"%s"\n}' "$volume" "$color"
fi



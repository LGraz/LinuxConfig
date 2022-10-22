#!/bin/bash
source $HOME/.config/scripts/status/get_color.sh
source $HOME/.config/scripts/status/i3block_click_toggle.sh

LCL=$HOME/.config/scripts/status/stat_wifi_left_click.sh
MCL=$HOME/.config/scripts/status/stat_wifi_middle_click.sh
RCL=$HOME/.config/scripts/status/stat_wifi_right_click.sh

check_click $LCL $MCL $RCL $BLOCK_BUTTON

ICON=""
TEXT=""
short=""
SSID=""

# Get connected wifi devices
eval NET_CONS=($(nmcli -c no -t -g connection,state,TYPE device |
    awk '/\<connected:wifi\>/' |
    awk -F: '{ printf("\"%s\"\n", $1) }'
))


# If NET_CONS is not empty, null or undefined
if [[ -n "${NET_CONS[0]}" ]]
then
    color=$(get_color $(nmcli -g signal device wifi))
    i=0
	for CON in "${NET_CONS[@]}"
	do
        # Get IPv4 address
        IP4=$(nmcli -g ip4.address connection show "$CON" |
            awk -F/ '{ print $1 }')
		
        # Get IPv6 address
        IP6=$(nmcli -g ip6.address connection show "$CON" |
            sed 's/\\//g' |
            awk -F/ '{ print $1 }')

        if [[ ! $i -eq 0 ]]
        then
            short="$short "
            TEXT="$TEXT  "
            SSID="$SSID  "
        fi
        short="$short$CON $IP4"
        TEXT="$TEXT$CON: IPv4: $IP4  IPv6: ${IP6^^}"
        SSID="$SSID$CON"
        i+=1
	done

    output="$ICON $SSID"

    # If left clicked
    if [[ -f $LCL ]]
    then
        short_output="$ICON [ $short ]"
        output="$ICON [ $TEXT ]"
    # If right clicked
    elif [[ $BLOCK_BUTTON -eq 3 ]]
    then
        xst -i -e nmtui
    fi
    printf '{"full_text":"%s", "short_text":"%s", "color":"%s"\n}' "$output" "$short_output" "$color"
fi


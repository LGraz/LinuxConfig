#!/bin/sh

# ------Get available windows:
windows=$(swaymsg -t get_tree | jq -r '
	recurse(.nodes[]?) |
		recurse(.floating_nodes[]?) |
		select(.type=="con"), select(.type=="floating_con") |
			(.id | tostring) + " " + .app_id + ": " + .name')

# remove hte lines from $windows that dont have any letter [a-zA-Z]
windows=$(echo "$windows" | sed -r '/[a-zA-Z]/!d' )

# ------Limit wofi's height with the number of opened windows:
height=$(echo "$windows" | wc -l)

# # ------Select window with wofi:
selected=$(echo "$windows" | wofi -d -i --lines "$height" -p "Switch to:" | awk '{print $1}')

# use dmenue instead:
# selected=$(echo "$windows" | dmenu -i -l "$height" -p "Switch to:" | awk '{print $1}')

# ------Tell sway to focus said window:
swaymsg [con_id="$selected"] focus

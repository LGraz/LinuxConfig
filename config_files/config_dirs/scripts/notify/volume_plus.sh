#!/bin/sh

notify="$HOME/.config/scripts/notify/volume_notify.sh"
max_volume="$HOME/.config/scripts/max_volume"
v="pamixer --get-volume"
msg=""
max=$(cat $max_volume)
echo $max
if [[ $(exec $v) -lt $max ]]; then
	pamixer -i 1 --allow-boost &&
		msg="Volume increased to $(exec $v)" ||
		msg="Failed to increase volume" &&
		pamixer -u
else
	msg="Volume is maximum"
fi
per=$((($(exec $v) * 100) / $max))
echo $per
$notify $per "$msg"

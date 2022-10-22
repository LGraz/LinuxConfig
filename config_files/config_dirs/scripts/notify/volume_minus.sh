#!/bin/sh

notify="$HOME/.config/scripts/notify/volume_notify.sh"
max_volume="$HOME/.config/scripts/max_volume"
v="pamixer --get-volume"
msg=""
max=$(cat $max_volume)

if [[ $(exec $v) -gt 0 ]]; then
	pamixer -d 1 --allow-boost &&
		msg="Volume decreased to $(exec $v)" ||
		msg="Failed to decrease volume" &&
		pamixer -u
else
	pamixer -m
	msg="Volume is muted"
fi
echo $msg
per=$((($(exec $v) * 100) / $max))
$notify $per "$msg"

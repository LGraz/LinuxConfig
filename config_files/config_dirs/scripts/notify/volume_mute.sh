#!/bin/sh

notify="$HOME/.config/scripts/notify/volume_notify.sh"
m="pamixer --get-mute"

pamixer -t

if $(exec $m); then
	$notify 0 "Audio muted"
else
	$notify $(pamixer --get-volume) "Audio unmuted"
fi


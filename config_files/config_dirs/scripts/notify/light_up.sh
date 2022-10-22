#!/bin/sh
xbacklight -inc 2 &&
	app="System"
	summary="Brightness increased to " &&
	light_level=`xbacklight -get` &&
	body="$summary$light_level"
	notify-send --urgency=low --expire-time=500 -a $app --icon=system "$body" -h string:x-canonical-private-synchronous:light -h int:value:$light_level

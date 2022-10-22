#!/bin/sh
xbacklight -dec 2 &&
	app="System"
	summary="Brightness decreased to " &&
	light_level=`xbacklight -get` &&
	body="$summary$light_level"
	notify-send --urgency=low --expire-time=500 -a $app --icon=system "$body" -h string:x-canonical-private-synchronous:light -h int:value:$light_level

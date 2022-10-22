#!/bin/sh
v=($1*1)
echo $2
notify-send -u low -a System "$2" -h string:x-canonical-private-synchronous:volume -h int:value:$v

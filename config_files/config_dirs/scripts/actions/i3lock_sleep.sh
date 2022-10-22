#!/bin/sh

i3lock -n -c 1C1C1C; killall i3lock

# Turn the screen off after a delay.
sleep 150; pgrep i3lock && xset dpms force off

# Hibernate after 15min
sleep 300; pgrep i3lock && systemctl hibernate


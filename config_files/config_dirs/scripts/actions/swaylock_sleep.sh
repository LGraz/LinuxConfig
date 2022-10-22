#!/bin/sh

# Single line command
# swaylock -e -n -c 1C1C1C -l --bs-hl-color ACACAC --caps-lock-bs-hl-color AC2C5C --caps-lock-key-hl-color AC2C5C --font Ubuntu --font-size 24 --indicator-idle-visible --indicator-radius 100 --indicator-thickness 10 --inside-color 1C1C1C --inside-clear-color 1C1C1C --inside-caps-lock-color 1C1C1C --inside-ver-color 1C1C1C --inside-wrong-color 1C1C1C --key-hl-color ACACAC --layout-bg-color 1C1C1C --layout-border-color 1C1C1C --layout-text-color 3E474E --ring-color 2C2C2C --ring-clear-color 5C4C3C --ring-caps-lock-color 2C2C2C --ring-ver-color 2CAC5C --ring-wrong-color AC2C5C --separator-color 2C2C2C --text-color 3E474E --text-clear-color AC5C2C --text-caps-lock-color 3E474E --text-ver-color 2CAC5C --text-wrong-color AC2C5C

swaylock -e -n -c 1C1C1C -l \
	--bs-hl-color ACACAC \
	--caps-lock-bs-hl-color AC2C5C \
	--caps-lock-key-hl-color AC2C5C \
	--font Ubuntu --font-size 24 \
	--indicator-idle-visible \
	--indicator-radius 100 \
	--indicator-thickness 10 \
	--inside-color 1C1C1C \
	--inside-clear-color 1C1C1C \
	--inside-caps-lock-color 1C1C1C \
	--inside-ver-color 1C1C1C \
	--inside-wrong-color 1C1C1C \
	--key-hl-color ACACAC \
	--layout-bg-color 1C1C1C \
	--layout-border-color 1C1C1C \
	--layout-text-color 3E474E \
	--ring-color 2C2C2C \
	--ring-clear-color 5C4C3C \
	--ring-caps-lock-color 2C2C2C \
	--ring-ver-color 2CAC5C \
	--ring-wrong-color AC2C5C \
	--separator-color 2C2C2C \
	--text-color 3E474E \
	--text-clear-color AC5C2C \
	--text-caps-lock-color 3E474E \
	--text-ver-color 2CAC5C \
	--text-wrong-color AC2C5C

# Turn the screen off after a delay.
sleep 150; pgrep swaylock && xset dpms force off

# Hibernate after 15min
sleep 300; pgrep swaylock && systemctl hibernate


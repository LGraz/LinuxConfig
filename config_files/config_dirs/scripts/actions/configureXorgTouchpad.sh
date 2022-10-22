#!/bin/sh

idd=$(xinput --list | grep 'Touchpad' | awk '{print $6}'| cut -d'=' -f2)

xinput set-int-prop $idd "libinput Tapping Enabled" 8 1
xinput set-int-prop $idd "libinput Tapping Drag Enabled" 8 1
xinput set-int-prop $idd "libinput Natural Scrolling Enabled" 8 1
xinput set-int-prop $idd "libinput Disable While Typing Enabled" 8 0
xinput set-int-prop $idd "libinput Middle Emulation Enabled" 8 1

#!/bin/bash

# set rate for keyboardrepeat  (250ms delay and 45Hz)
xset r rate 250 45

# let caps be 3rd level modifier

xmodmap -e "remove lock = Caps_Lock"
setxkbmap -option
setxkbmap -option caps:hyper
# setxkbmap -option lv3:win_switch
setxkbmap -option lv3:lwin_switch
# setxkbmap -option lv3:rwin_switch

source ~/.env_vars
source ~/.aliases

# disable screensaver
xset s off
xset -dpms
# xset s noblank

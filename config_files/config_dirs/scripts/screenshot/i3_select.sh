#!/bin/bash
name="/home/$USER/Pictures/Screenshots/""$(date +"%Y%m%d%H%M%S")""_REGION.png"
scrot -s $name && echo 'Saving as '$name || echo "screenshot failed"
xclip -selection clipboard -t image/png $name

#!/usr/bin/env bash

# disable Wayland
sudo sed -i 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm/custom.conf

# add bluetooth shortcut
python3 ~/ArchTitus/scripts/add_gnome_shortcut.py 'connect wh910' '~/.connect_wh910n.sh' '<Super>h'

# fix KEYMAP
gsettings reset org.gnome.desktop.input-sources sources
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'de+nodeadkeys')]"
localectl set-x11-keymap de acer_laptop
# if ctl+. gives e_ then type `ibus-setup` and ggo to emoji and disable shortcut

# SHORTCUTS
python3 ~/ArchTitus/scripts/add_gnome_shortcut.py 'open guake' 'guake' '<Super>e'



#######################################
###  EXTENSIONS
#######################################
# get gnome version
temp=`gnome-shell --version`
GNOME_VERSION=${temp:12:2} && echo "gnome version: $GNOME_VERSION"

# get extension installer:
yay -S --noconfirm --needed gnome-shell-extension-installer

printf "$GNOME_VERSION\nq" | gnome-shell-extension-installer 779 # clipboard-indicator
printf "$GNOME_VERSION\nq" | gnome-shell-extension-installer 277 # impatience
printf "$GNOME_VERSION\nq" | gnome-shell-extension-installer 3357 # material shell
printf "$GNOME_VERSION\nq" | gnome-shell-extension-installer 1460 # vitals (cpu/ram/storage/..)
printf "$GNOME_VERSION\nq" | gnome-shell-extension-installer 1287 # unite (remove window top panel)
printf "$GNOME_VERSION\nq" | gnome-shell-extension-installer 1112 # screenshot tool
printf "$GNOME_VERSION\nq" | gnome-shell-extension-installer 3088 # Extension list
printf "$GNOME_VERSION\nq" | gnome-shell-extension-installer 906 # Sound output chooser

reboot
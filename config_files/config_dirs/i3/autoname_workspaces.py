#!/usr/bin/env python3
#
# github.com/justbuchanan/i3scripts
#
# This script listens for i3 events and updates workspace names to show icons
# for running programs.  It contains icons for a few programs, but more can
# easily be added by editing the WINDOW_ICONS list below.
#
# It also re-numbers workspaces in ascending order with one skipped number
# between monitors (leaving a gap for a new workspace to be created). By
# default, i3 workspace numbers are sticky, so they quickly get out of order.
#
# Dependencies
# * xorg-xprop  - install through system package manager
# * i3ipc       - install with pip
# * fontawesome - install with pip
#
# sudo pacman -S -needed xorg-xprop
# pip3 install i3ipc
# pip3 install fontawesome
#
# Installation:
# * Download this repo and place it in ~/.config/i3/ (or anywhere you want)
# * Add "exec_always ~/.config/i3/i3scripts/autoname_workspaces.py &" to your i3 config
# * Restart i3: $ i3-msg restart
#
# Configuration:
# The default i3 config's keybindings reference workspaces by name, which is an
# issue when using this script because the "names" are constantly changing to
# include window icons.  Instead, you'll need to change the keybindings to
# reference workspaces by number.  Change lines like:
#   bindsym $mod+1 workspace 1
# To:
#   bindsym $mod+1 workspace number 1

import argparse
import i3ipc
import logging
import signal
import sys
import fontawesome as fa

from util import *

# Add icons here for common programs you use.  The keys are the X window class
# (WM_CLASS) names (lower-cased) and the icons can be any text you want to
# display.
#
# Most of these are character codes for font awesome:
#   http://fortawesome.github.io/Font-Awesome/icons/
#
# If you're not sure what the WM_CLASS is for your application, you can use
# xprop (https://linux.die.net/man/1/xprop). Run `xprop | grep WM_CLASS`
# then click on the application you want to inspect.
WINDOW_ICONS = {
    "alacritty": fa.icons["terminal"],
    "albert": "_",
    "arandr": fa.icons["desktop"],
    "atom": fa.icons["code"],
    "banshee": fa.icons["play"],
    "blender": fa.icons["cube"],
    "blueman-manager": fa.icons["bluetooth"],
    "chromium-browser": fa.icons["chrome"],
    "chromium": fa.icons["chrome"],
    "owncloud": fa.icons["cloud"],
    "code": fa.icons["code"],
    "cura": fa.icons["cube"],
    "darktable": fa.icons["image"],
    # "discord": fa.icons["comment"],
    "discord": fa.icons["discord"],
    "eclipse": fa.icons["code"],
    "emacs": fa.icons["code"],
    "eog": fa.icons["image"],
    "evince": fa.icons["file-pdf"],
    "evolution": fa.icons["envelope"],
    "feh": fa.icons["image"],
    "ferdium": fa.icons["whatsapp"],
    "file-roller": fa.icons["compress"],
    "filezilla": fa.icons["server"],
    "firefox-esr": fa.icons["firefox"],
    "firefox": fa.icons["firefox"],
    "geary": fa.icons["inbox"],
    "gedit": fa.icons["edit"],
    "gimp-2.8": fa.icons["image"],
    "gimp": fa.icons["image"],
    "github desktop": fa.icons["code-branch"],
    "gnome-calculator": fa.icons["calculator"],
    "gnome-control-center": fa.icons["toggle-on"],
    "gnome-software": fa.icons["shopping-bag"],
    "gnome-system-monitor": fa.icons["chart-area"],
    "gnome-terminal-server": fa.icons["terminal"],
    "gnome-tweaks": fa.icons["toggle-on"],
    "google play music desktop player": fa.icons["play"],
    "google-chrome": fa.icons["chrome"],
    "gpick": fa.icons["eye-dropper"],
    "gucharmap": fa.icons["fonticons"],
    "imv": fa.icons["image"],
    "insomnia": fa.icons["globe"],
    "java": fa.icons["code"],
    "jetbrains-idea": fa.icons["code"],
    "jetbrains-studio": fa.icons["code"],
    "keepassxc": fa.icons["key"],
    "keybase": fa.icons["key"],
    "kicad": fa.icons["microchip"],
    "kitty": fa.icons["terminal"],
    "libreoffice-draw": fa.icons["file-alt"],
    "libreoffice-impress": fa.icons["file-alt"],
    "libreoffice-writer": fa.icons["file-alt"],
    "libreoffice": fa.icons["file-alt"],
    "lua5.1": fa.icons["moon"],
    "microsoft teams - preview": fa.icons["users"],
    "minetime": fa.icons["calendar-alt"],
    "mpv": fa.icons["tv"],
    "mupdf": fa.icons["file-pdf"],
    "mysql-workbench-bin": fa.icons["database"],
    "nautilus": fa.icons["copy"],
    "nemo": fa.icons["copy"],
    "obsidian": fa.icons["gem"],
    "openscad": fa.icons["cube"],
    "org.gnome.gedit": fa.icons["file-signature"],
    # "org.gnome.nautilus": fa.icons["copy"],
    "org.gnome.nautilus": fa.icons["folder"],
    "pavucontrol": fa.icons["volume-up"],
    "pdfarranger": fa.icons["file-pdf"],
    "postman": fa.icons["space-shuttle"],
    "prusa-slicer": fa.icons["cube"],
    "quasselclient": fa.icons["comments"],
    "rambox": fa.icons["whatsapp"],
    "rhythmbox": fa.icons["play"],
    "rstudio": "R",
    "robo3t": fa.icons["database"],
    "seahorse": fa.icons["key"],
    "signal": fa.icons["comment"],
    "slack": fa.icons["slack"],
    "slic3r.pl": fa.icons["cube"],
    "spotify": fa.icons["music"],  # could also use the 'spotify' icon
    "spotify": fa.icons["spotify"],
    "squeak": fa.icons["fly"],
    "steam": fa.icons["steam"],
    "subl": fa.icons["file-alt"],
    "subl3": fa.icons["file-alt"],
    "sublime_text": fa.icons["file-alt"],
    "superproductivity": fa.icons["hourglass"],
    "telegram": fa.icons["telegram"],
    "terminator": fa.icons["terminal"],
    "thunar": fa.icons["copy"],
    # "thunderbird": fa.icons["envelope-open-text"],
    "thunderbird": fa.icons["envelope"],
    "totem": fa.icons["play"],
    "urxvt": fa.icons["terminal"],
    "vcastqt": fa.icons["chevron-right"],
    "xfce4-terminal": fa.icons["terminal"],
    "xournal": fa.icons["file-alt"],
    "yelp": fa.icons["code"],
    "youtube.com": fa.icons["youtube"],
    "zenity": fa.icons["window-maximize"],
    # "zoom": fa.icons["comment"],
    "zoom": fa.icons["video"],
    "zoom ": fa.icons["video"],
    "Zoom - Licensed Account": fa.icons["video"],
    "Zoom Meeting": fa.icons["video"],
    # "zotero": fa.icons["file-pdf"],
    "zotero": "Z",
}


# This icon is used for any application not in the list above
DEFAULT_ICON = "*"

# Global setting that determines whether workspaces will be automatically
# re-numbered in ascending order with a "gap" left on each monitor. This is
# overridden via command-line flag.
RENUMBER_WORKSPACES = True


def ensure_window_icons_lowercase():
    global WINDOW_ICONS
    WINDOW_ICONS = {name.lower(): icon for name, icon in WINDOW_ICONS.items()}


def icon_for_window(window):
    # Try all window classes and use the first one we have an icon for
    classes = xprop(window.window, "WM_CLASS")
    if classes != None and len(classes) > 0:
        for cls in classes:
            cls = cls.lower()  # case-insensitive matching
            if cls in WINDOW_ICONS:
                return WINDOW_ICONS[cls]
    wm_name = xprop(window.window, "WM_NAME")
    if wm_name != None and len(wm_name) > 0:
        for names in wm_name:
            names = names.lower()  # case-insensitive matching
            for name in names.split(" "):
                if name in WINDOW_ICONS:
                    return WINDOW_ICONS[name]
    logging.info("No icon available for window with classes: %s" % str(classes))
    return DEFAULT_ICON


# renames all workspaces based on the windows present
# also renumbers them in ascending order, with one gap left between monitors
# for example: workspace numbering on two monitors: [1, 2, 3], [5, 6]
def rename_workspaces(i3, icon_list_format="default"):
    ws_infos = i3.get_workspaces()
    prev_output = None
    n = 1
    for ws_index, workspace in enumerate(i3.get_tree().workspaces()):
        ws_info = ws_infos[ws_index]

        name_parts = parse_workspace_name(workspace.name)
        icon_list = [icon_for_window(w) for w in workspace.leaves()]
        new_icons = format_icon_list(icon_list, icon_list_format)

        # As we enumerate, leave one gap in workspace numbers between each monitor.
        # This leaves a space to insert a new one later.
        if ws_info.output != prev_output and prev_output != None:
            n += 1
        prev_output = ws_info.output

        # optionally renumber workspace
        new_num = n if RENUMBER_WORKSPACES else name_parts.num
        n += 1

        new_name = construct_workspace_name(
            NameParts(num=new_num, shortname=name_parts.shortname, icons=new_icons)
        )
        if workspace.name == new_name:
            continue
        i3.command('rename workspace "%s" to "%s"' % (workspace.name, new_name))


# Rename workspaces to just numbers and shortnames, removing the icons.
def on_exit(i3):
    for workspace in i3.get_tree().workspaces():
        name_parts = parse_workspace_name(workspace.name)
        new_name = construct_workspace_name(
            NameParts(num=name_parts.num, shortname=name_parts.shortname, icons=None)
        )
        if workspace.name == new_name:
            continue
        i3.command('rename workspace "%s" to "%s"' % (workspace.name, new_name))
    i3.main_quit()
    sys.exit(0)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Rename workspaces dynamically to show icons for running programs."
    )
    parser.add_argument(
        "--norenumber_workspaces",
        action="store_true",
        default=False,
        help="Disable automatic workspace re-numbering. By default, workspaces are automatically re-numbered in ascending order.",
    )
    parser.add_argument(
        "--icon_list_format",
        type=str,
        default="default",
        help="The formatting of the list of icons."
        "Accepted values:"
        "    - default: no formatting,"
        "    - mathematician: factorize with superscripts (e.g. aababa -> a⁴b²),"
        "    - chemist: factorize with subscripts (e.g. aababa -> a₄b₂).",
    )
    args = parser.parse_args()

    RENUMBER_WORKSPACES = not args.norenumber_workspaces

    logging.basicConfig(level=logging.INFO)

    ensure_window_icons_lowercase()

    i3 = i3ipc.Connection()

    # Exit gracefully when ctrl+c is pressed
    for sig in [signal.SIGINT, signal.SIGTERM]:
        signal.signal(sig, lambda signal, frame: on_exit(i3))

    rename_workspaces(i3, icon_list_format=args.icon_list_format)

    # Call rename_workspaces() for relevant window events
    def event_handler(i3, e):
        if e.change in ["new", "close", "move"]:
            rename_workspaces(i3, icon_list_format=args.icon_list_format)

    i3.on("window", event_handler)
    i3.on("workspace::move", event_handler)
    i3.main()

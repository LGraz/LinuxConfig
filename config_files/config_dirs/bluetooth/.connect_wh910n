#!/usr/bin/bash
rfkill unblock all #unblock bluetooth if is soft-blocked
bltid="38:18:4C:DA:A8:55" # WH-910N
bluetoothctl power on
bluetoothctl pair $bltid
bluetoothctl connect $bltid



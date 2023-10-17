#!/usr/bin/env bash
while read -r line 
do
        WINDOW_ID="$(echo  $line | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')"
        NAME=$(xprop -id $WINDOW_ID | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
        if [[ "$NAME_OLD" == *"albert — Albert"* ]] && [[ "$NAME" != *"albert — Albert"* ]]; then
                albert hide
        fi
        NAME_OLD="$NAME"
done < <(xprop -spy -root _NET_ACTIVE_WINDOW)

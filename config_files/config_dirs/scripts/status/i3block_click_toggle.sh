#!/bin/sh

check_click() {
    LCL="$1"
    MCL="$2"
    RCL="$3"
    BLOCK_BUTTON="$4"

    if [[ $BLOCK_BUTTON -eq 1 ]]
    then
        rm -rf "$MCL" ||:
        rm -rf "$RCL" ||:
    
        if [[ -f "$LCL" ]]
        then
            rm -rf "$LCL" ||:
        else
            touch "$LCL"
        fi
    elif [[ $BLOCK_BUTTON -eq 2 ]]
    then
        rm -rf "$LCL" ||:
        rm -rf "$RCL" ||:

        if [[ -f "$MCL" ]]
        then
            rm -rf "$MCL" ||:
        else
            touch "$MCL"
        fi
    elif [[ $BLOCK_BUTTON -eq 3 ]]
    then
        rm -rf "$LCL" ||:
        rm -rf "$MCL" ||: 

        if [[ -f "$RCL" ]]
        then
            rm -rf "$RCL" ||:
        else
            touch "$RCL"
        fi
    fi
}

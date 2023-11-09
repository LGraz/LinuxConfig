#! /bin/bash
# use dmenue to chose a script in ~/LinuxConfig/user_scripts and run it

# the scripts are assumed to be executable
# the script will be run in the background

# dmenu options
DMENU_OPTIONS="-i -l 20 -fn 'Ubuntu Mono-12' -nb '#000000' -nf '#ffffff' -sb '#000000' -sf '#ff0000'"

# get the script to run
SCRIPT=$(find ~/LinuxConfig/user_scripts -type f -executable | dmenu $DMENU_OPTIONS)
cd ~/LinuxConfig/user_scripts
SCRIPT=$(find . -type f -executable -exec realpath --relative-to=. {} \; | dmenu -p "Run script:" -b -nf '#BBBBBB' -nb '#222222' -sb '#EF11FF' -sf '#000000' -fn 'monospace-16')
cd -

# if nothing was selected, exit
if [ -z "$SCRIPT" ]; then
    echo "No script selected"
    exit
fi

# run the script
"$HOME/LinuxConfig/user_scripts/$SCRIPT" 


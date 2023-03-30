# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.env_vars
source ~/.aliases

# Prevent nested instances
ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}

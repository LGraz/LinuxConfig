#! /usr/bin/bash
# combines all outputs to one -> two headphones
# https://askubuntu.com/questions/78174/play-sound-through-two-or-more-outputs-devices

pactl load-module module-combine-sink

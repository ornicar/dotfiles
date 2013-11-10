#!/bin/bash
# Default acpi script that takes an entry for all actions

# to use, you need that in /etc/acpi/events/anything:
# event=.*
# action=/path/to/this/file.sh %e

export PULSE_RUNTIME_PATH="/run/user/1000/pulse/"

case "$1" in
    video/brightnessdown) /home/thib/.scripts/mac-brightness down;;
    video/brightnessup) /home/thib/.scripts/mac-brightness up;;
    # sink 1 = builtin, sink 4 = bluetooth
    button/volumedown) for i in "1" "4"; do sudo -u thib -E pactl set-sink-volume "$i" -- -5%; done;;
    button/volumeup) for i in "1" "4"; do sudo -u thib -E pactl set-sink-volume "$i" -- +5%; done;;
    button/mute) for i in "1" "4"; do sudo -u thib -E pactl set-sink-mute "$i" -- toggle; done;;
    cd/play) /home/thib/.scripts/music radio-toggle;;
    *) logger "ACPI group/action undefined: $1 / $2";;
esac

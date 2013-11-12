#!/usr/bin/zsh
# Default acpi script that takes an entry for all actions

# to use, you need that in /etc/acpi/events/anything:
# event=.*
# action=/path/to/this/file.sh %e

export PULSE_RUNTIME_PATH="/run/user/1000/pulse/"

case "$1" in
  video/brightnessdown) /home/thib/.scripts/mac-brightness down;;
  video/brightnessup) /home/thib/.scripts/mac-brightness up;;
  button/volumedown) for i in $(sudo -u thib -E pacmd list-sinks | grep index | sed 's/[^0-9]//g'); do echo "$i"; sudo -u thib -E pactl set-sink-volume "$i" -- -10%; done;;
  button/volumeup) for i in $(sudo -u thib -E pacmd list-sinks | grep index | sed 's/[^0-9]//g'); do sudo -u thib -E pactl set-sink-volume "$i" -- +10%; done;;
  button/mute) for i in $(sudo -u thib -E pacmd list-sinks | grep index | sed 's/[^0-9]//g'); do sudo -u thib -E pactl set-sink-mute "$i" -- toggle; done;;
  cd/play) sudo -u thib -E mpc toggle;;
  cd/next) sudo -u thib -E mpc next;;
  cd/prev) sudo -u thib -E mpc prev;;
  *) logger "ACPI group/action undefined: $1 / $2";;
esac

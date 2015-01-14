#!/usr/bin/zsh
# Default acpi script that takes an entry for all actions

# to use, you need that in /etc/acpi/events/anything:
# event=.*
# action=/path/to/this/file.sh %e

export PULSE_RUNTIME_PATH="/run/user/1000/pulse/"

case "$1" in
  video/brightnessdown) /home/thib/.scripts/lenovo-brightness down;;
  video/brightnessup) /home/thib/.scripts/lenovo-brightness up;;
  button/volumedown) for i in $(sudo -u thib -E pacmd list-sinks | grep index | sed 's/[^0-9]//g'); do echo "$i"; sudo -u thib -E pactl set-sink-volume "$i" -- -5%; done;;
  button/volumeup) for i in $(sudo -u thib -E pacmd list-sinks | grep index | sed 's/[^0-9]//g'); do sudo -u thib -E pactl set-sink-volume "$i" -- +5%; done;;
  button/mute) for i in $(sudo -u thib -E pacmd list-sinks | grep index | sed 's/[^0-9]//g'); do sudo -u thib -E pactl set-sink-mute "$i" -- toggle; done;;
  button/sleep) sudo -u thib -E xscreensaver-command --lock;;
  cd/play) sudo -u thib -E mpc toggle;;
  cd/next) sudo -u thib -E mpc next;;
  cd/prev) sudo -u thib -E mpc prev;;
  # battery)
  #   case "$4" in
  #     00000000)
  #       cpupower frequency-set -g powersave
  #       ;;
  #     00000001)
  #       cpupower frequency-set -g performance
  #       ;;
  #   esac
  #   ;;
  *) logger "ACPI group/action undefined: $1/$2 $3,$4";;
esac

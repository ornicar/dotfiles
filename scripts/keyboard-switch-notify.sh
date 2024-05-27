#!/bin/sh
swaymsg input type:keyboard xkb_switch_layout next
swaymsg -t get_inputs | jq 'map(select(has("xkb_active_layout_name")))[0].xkb_active_layout_name' | xargs notify-send -t 1000 --

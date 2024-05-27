#!/bin/sh
FILENAME="screenshot-`date +%F-%T`"
grim -g "$(slurp)" - | wl-copy
notify-send  -t 1000 "Screenshot -> clipboard"

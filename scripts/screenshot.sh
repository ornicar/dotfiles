#!/bin/sh

if [ "$1" = "clipboard" ]; then
  grim -g "$(slurp)" - | wl-copy
  notify-send  -t 1000 "Screenshot -> clipboard"
else
  FILENAME="screenshot-`date +%F-%T`"
  grim -g "$(slurp)" $FILENAME.png
  notify-send $FILENAME -t 3000
fi

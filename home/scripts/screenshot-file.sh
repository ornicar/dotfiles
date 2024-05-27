#!/bin/sh
FILENAME="screenshot/`date +%F-%T`"
grim -g "$(slurp)" $FILENAME.png
notify-send $FILENAME

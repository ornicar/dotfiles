#!/bin/sh

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
  startx
fi

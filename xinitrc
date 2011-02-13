#!/bin/sh

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

# Remap keys
xmodmap $HOME/.Xmodmap &&

xrdb $HOME/.Xdefaults                       # load Xdefaults
xsetroot -solid black                       # black background
xset fp+ /usr/share/fonts/local             # add local fonts
xset s 120 120                              # set monitor to sleep
xset s off                                  # disable screensaver
xset -b                                     # Disable system bell
xset r rate 200 50                          # Repeat keys way faster please
unclutter -root -idle 1 &                   # kill inactive rat cursor
urxvtd -q -f -o                             # start urxvt server
$HOME/.scripts/collector_daemon &           # start cpu and lichess data collector

(sleep 1 && urxvtc -e $HOME/.tmux/menu) &   # Give ratpoison one second to start, then open urxvt

# Run window manager
exec ratpoison

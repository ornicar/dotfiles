#!/bin/sh

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

# Remap keys
xmodmap $HOME/.Xmodmap &&

xrdb $HOME/.Xdefaults                       # load Xdefaults
xset fp+ /usr/share/fonts/local             # add local fonts
xset s 300 300                              # set monitor to sleep after 5 mins
xset s off                                  # disable screensaver
xset -b                                     # Disable system bell
urxvtd -q -f -o                             # start urxvt server
tmux new-session -d -s scratch              # start tmux server with the scratch session
$HOME/.scripts/collector_daemon &           # start cpu and lichess data collector

# Run window manager
exec awesome

#!/bin/sh

# Start data collector daemon (used by byobu)
$HOME/.scripts/collector_daemon &

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp &

# Disable system bell
xset -b off

xrdb $HOME/.Xdefaults &                     # load Xdefaults
xset fp+ /usr/share/fonts/local &           # add local fonts
xset s 300 300 &                            # set monitor to sleep 5 mins
xset s off &                                # disable screensaver
urxvtd -q -f -o &                           # start urxvt daemon

# Remap keys
xmodmap $HOME/.Xmodmap &&

# Run window manager
exec awesome

#!/bin/sh

# For dunst to find X
systemctl --user import-environment DISPLAY

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

xrdb $HOME/.Xresources                       # load Xresources

xset s 300 300                              # set monitor to sleep
# xset s off                                  # disable screensaver
xset -b                                     # Disable system bell
unclutter --fork --timeout 2                # kill inactive rat cursor

# sh $HOME/.fehbg &
pgrep redshift &> /dev/null || redshift -r &> /dev/null &

# xautolock -time 10 -locker "~/.scripts/lock" &

$HOME/.scripts/input-xps9700

xbindkeys --poll-rc &

# nm-applet    2>&1 > /dev/null &

i3

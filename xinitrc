#!/bin/sh

# For dunst to find X
systemctl --user import-environment DISPLAY

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

xrdb $HOME/.Xresources                       # load Xresources

xset s 600 600                              # set monitor to sleep
xset s off                                  # disable screensaver
# xset -b                                     # Disable system bell
unclutter --fork --timeout 2                # kill inactive rat cursor

# sh $HOME/.fehbg &
# pgrep redshift &> /dev/null || redshift -r &> /dev/null &

# xautolock -time 10 -locker "~/.scripts/lock" &

$HOME/.scripts/input-kinesis

# xbindkeys --poll-rc &

export QT_QPA_PLATFORMTHEME=qt5ct

# nm-applet    2>&1 > /dev/null &

i3

#!/bin/sh

# For dunst to find X
systemctl --user import-environment DISPLAY

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

xrdb $HOME/.Xresources                      # load Xresources

xset s off                                  # disable screensaver, use DPMS instead
xset dpms 180 0 0                           # turn screen off after 3 minutes
unclutter --fork --timeout 2                # kill inactive rat cursor

pgrep redshift &> /dev/null || redshift -r &> /dev/null &

watch -n 1200 feh --bg-fill --randomize ~/image/wallpaper/ &

blueman-applet &

$HOME/.scripts/input-crom

export QT_QPA_PLATFORMTHEME=qt5ct

i3

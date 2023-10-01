#!/bin/sh

# For dunst to find X
systemctl --user import-environment DISPLAY

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

xrdb $HOME/.Xresources # load Xresources

xset s 300 300 # set monitor to sleep
xset s off     # disable screensaver
xset -b        # Disable system bell
#unclutter --fork --timeout 2                # kill inactive rat cursor

pgrep redshift &
>/dev/null || redshift -r &
>/dev/null &

#watch -n 1200 feh --bg-fill --randomize ~/image/wallpaper/ &

blueman-applet &

$HOME/.scripts/input-xps9700

export QT_QPA_PLATFORMTHEME=qt5ct

i3

#!/bin/sh

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

xrdb $HOME/.Xresources                       # load Xresources

xsetroot -solid black                       # black background
xset s 600 600                              # set monitor to sleep
xset s off                                  # disable screensaver
xset -b                                     # Disable system bell
unclutter -root -idle 2 &                   # kill inactive rat cursor
urxvtd -q -f -o                             # start urxvt server

# sh $HOME/.fehbg &
pgrep redshift &> /dev/null || redshift -r &> /dev/null &

# xautolock -time 10 -locker "~/.scripts/lock" &

$HOME/.scripts/input-asus

# nm-applet    2>&1 > /dev/null &

# exec i3
i3

#!/bin/sh

export GDK_SCALE=2 # 4k GTK3
export QT_AUTO_SCREEN_SCALE_FACTOR=0 # QT5 no auto scale
export QT_SCALE_FACTOR=2 # QT5 manual x2

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

$HOME/.scripts/input-xps15

# nm-applet    2>&1 > /dev/null &

i3

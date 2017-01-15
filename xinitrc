#!/bin/sh

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

xrdb $HOME/.Xresources                       # load Xresources

# xsetroot -solid black                       # black background
xset s 600 600                              # set monitor to sleep
# xset s off                                  # disable screensaver
xset -b                                     # Disable system bell
# unclutter -root -idle 2 &                   # kill inactive rat cursor
syndaemon -i 1 -t -k -d -R &                   # disable the pad when typing
# synclient TapButton1=1 TapButton2=3 TapButton3=2 # tap to click
# synclient RightButtonAreaLeft=0             # disable right click area
# synclient RightButtonAreaTop=0              # disable right click area
urxvtd -q -f -o                             # start urxvt server

sh $HOME/.fehbg &
redshift -r &

# xautolock -time 10 -locker "~/.scripts/lock" &

$HOME/.scripts/keyboard-dell

exec i3

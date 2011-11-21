#!/bin/sh

setxkbmap us -variant colemak

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

# Remap keys
xmodmap $HOME/.Xmodmap &&

xrdb $HOME/.Xdefaults                       # load Xdefaults
xsetroot -solid black                       # black background
xset s 300 300                              # set monitor to sleep
#xset s off                                  # disable screensaver
xset -b                                     # Disable system bell
xset r rate 280 50                          # Repeat keys way faster please
unclutter -root -idle 1 &                   # kill inactive rat cursor
urxvtd -q -f -o                             # start urxvt server
$HOME/.scripts/collector_daemon &           # start cpu and lichess data collector

urxvtc -e $HOME/.tmux/menu &

# store X clipboards for use with dmenuclip
clipbored &

# Run window manager
exec xmonad

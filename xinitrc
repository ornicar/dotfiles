#!/bin/sh

setxkbmap us -variant colemak

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

# Remap keys
xmodmap $HOME/.Xmodmap &&

xrdb $HOME/.Xresources                       # load Xresources

xsetroot -solid black                       # black background
xset s 200 200                              # set monitor to sleep
#xset s off                                  # disable screensaver
xset -b                                     # Disable system bell
xset r rate 220 56                          # Repeat keys way faster please
unclutter -root -idle 2 &                   # kill inactive rat cursor
urxvtd -q -f -o                             # start urxvt server

# not used anymore
# $HOME/.scripts/collector_daemon &           # start data collector

urxvtc -e $HOME/.tmux/menu &

# pulseaudio --start

# Run window manager
exec xmonad

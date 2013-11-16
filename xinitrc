#!/bin/sh

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

xrdb $HOME/.Xresources                       # load Xresources

xsetroot -solid black                       # black background
# xset s 200 200                              # set monitor to sleep
xset s off                                  # disable screensaver
xset -b                                     # Disable system bell
unclutter -root -idle 2 &                   # kill inactive rat cursor
syndaemon -i 2 -t -k -d &                   # disable the pad when typing
urxvtd -q -f -o                             # start urxvt server

sudo pkill tmux-status-daemon
sudo $HOME/.tmux/tmux-status-daemon &           # start data collector

urxvtc -e $HOME/.tmux/menu &

pulseaudio --start

$HOME/.scripts/keyboard-mac

# Run window manager
exec xmonad

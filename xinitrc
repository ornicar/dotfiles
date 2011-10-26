#!/bin/sh

setxkbmap us -variant colemak

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

# Remap keys
xmodmap $HOME/.Xmodmap &&

xrdb $HOME/.Xdefaults                       # load Xdefaults
xsetroot -solid black                       # black background
#xset fp+ /usr/share/fonts/local             # add local fonts
xset s 120 120                              # set monitor to sleep
#xset s off                                  # disable screensaver
xset -b                                     # Disable system bell
xset r rate 250 50                          # Repeat keys way faster please
unclutter -root -idle 1 &                   # kill inactive rat cursor
urxvtd -q -f -o                             # start urxvt server
$HOME/.scripts/collector_daemon &           # start cpu and lichess data collector

#ishastone=$(xrandr | awk '/LVDS1 connected/')
#[ -n isexercisehardware ] && xrandr --output HDMI1 --off --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output VGA1 --mode 1680x1050 --pos 1366x0 --rotate normal

(sleep 1 && urxvtc -e $HOME/.tmuxinator/media.tmux) &   # Give ratpoison one second to start, then open urxvt

# Run window manager
exec ratpoison

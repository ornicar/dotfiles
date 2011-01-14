#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Start data collector daemon (used by byobu)
~/.scripts/collector_daemon &

# Kill X
setxkbmap -option terminate:ctrl_alt_bksp &

# Rebind caps to escape
xmodmap $HOME/.Xmodmap &&

# Run window manager
exec awesome

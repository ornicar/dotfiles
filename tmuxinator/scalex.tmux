#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/scalex
tmux start-server

if ! $(tmux has-session -t 'scalex'); then

tmux new-session -d -s 'scalex' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'scalex':2 -n 'zsh'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'scalex':1 'vim' C-m


# tab "zsh"



tmux select-window -t 'scalex':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'scalex'
else
    tmux -u switch-client -t 'scalex'
fi

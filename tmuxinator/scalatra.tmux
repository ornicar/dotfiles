#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/scalatra
tmux start-server

if ! $(tmux has-session -t 'scalatra'); then

tmux new-session -d -s 'scalatra' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'scalatra':2 -n 'zsh'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'scalatra':1 'vim' C-m


# tab "zsh"



tmux select-window -t 'scalatra':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'scalatra'
else
    tmux -u switch-client -t 'scalatra'
fi

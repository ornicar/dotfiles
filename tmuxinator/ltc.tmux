#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/ltc
tmux start-server

if ! $(tmux has-session -t 'ltc'); then

tmux new-session -d -s 'ltc' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'ltc':2 -n 'git'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'ltc':1 'vim' C-m


# tab "git"



tmux select-window -t 'ltc':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'ltc'
else
    tmux -u switch-client -t 'ltc'
fi

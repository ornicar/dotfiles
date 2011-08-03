#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/praxeum
tmux start-server

if ! $(tmux has-session -t 'praxeum'); then

tmux new-session -d -s 'praxeum' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'praxeum':2 -n 'zsh'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'praxeum':1 'vim' C-m


# tab "zsh"



tmux select-window -t 'praxeum':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'praxeum'
else
    tmux -u switch-client -t 'praxeum'
fi

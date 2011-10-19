#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/scala-elasticsearch
tmux start-server

if ! $(tmux has-session -t 'scala-elasticsearch'); then

tmux new-session -d -s 'scala-elasticsearch' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'scala-elasticsearch':2 -n 'zsh'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'scala-elasticsearch':1 'vim' C-m


# tab "zsh"



tmux select-window -t 'scala-elasticsearch':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'scala-elasticsearch'
else
    tmux -u switch-client -t 'scala-elasticsearch'
fi

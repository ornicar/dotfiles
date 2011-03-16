#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace
tmux start-server

if ! $(tmux has-session -t 'extra'); then

tmux new-session -d -s 'extra' -n 'workspace'
tmux set-option base-index 1



# set up tabs and panes

# tab "workspace"



tmux select-window -t 'extra':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'extra'
else
    tmux -u switch-client -t 'extra'
fi

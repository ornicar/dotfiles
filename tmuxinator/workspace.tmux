#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace
tmux start-server

if ! $(tmux has-session -t 'workspace'); then

tmux new-session -d -s 'workspace' -n 'zsh'
tmux set-option base-index 1



# set up tabs and panes

# tab "zsh"



tmux select-window -t 'workspace':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'workspace'
else
    tmux -u switch-client -t 'workspace'
fi

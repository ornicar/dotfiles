#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data
tmux start-server

if ! $(tmux has-session -t 'media'); then

tmux new-session -d -s 'media' -n 'zsh'
tmux set-option base-index 1



# set up tabs and panes

# tab "zsh"



tmux select-window -t 'media':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'media'
else
    tmux -u switch-client -t 'media'
fi

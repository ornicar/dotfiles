#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/haskeum
tmux start-server

if ! $(tmux has-session -t 'haskeum'); then

tmux new-session -d -s 'haskeum' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'haskeum':2 -n 'zsh'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'haskeum':1 'vim' C-m


# tab "zsh"



tmux select-window -t 'haskeum':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'haskeum'
else
    tmux -u switch-client -t 'haskeum'
fi

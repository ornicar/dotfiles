#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/symfony2bundles
tmux start-server

if ! $(tmux has-session -t 's2b'); then

tmux new-session -d -s 's2b' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 's2b':2 -n 'git'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 's2b':1 'vim' C-m


# tab "git"

tmux send-keys -t 's2b':2 'tig' C-m



tmux select-window -t 's2b':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 's2b'
else
    tmux -u switch-client -t 's2b'
fi

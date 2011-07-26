#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/haskell-test
tmux start-server

if ! $(tmux has-session -t 'haskell-test'); then

tmux new-session -d -s 'haskell-test' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'haskell-test':2 -n 'zsh'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'haskell-test':1 'vim' C-m


# tab "zsh"



tmux select-window -t 'haskell-test':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'haskell-test'
else
    tmux -u switch-client -t 'haskell-test'
fi

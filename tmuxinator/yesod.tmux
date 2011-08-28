#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/yesod
tmux start-server

if ! $(tmux has-session -t 'yesod'); then

tmux new-session -d -s 'yesod' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'yesod':2 -n 'zsh'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'yesod':1 'vim' C-m


# tab "zsh"



tmux select-window -t 'yesod':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'yesod'
else
    tmux -u switch-client -t 'yesod'
fi

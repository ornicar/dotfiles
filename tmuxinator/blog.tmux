#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/ornicar.github.com
tmux start-server

if ! $(tmux has-session -t 'blog'); then

tmux new-session -d -s 'blog' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'blog':2 -n 'blog'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'blog':1 'vim' C-m


# tab "blog"

tmux send-keys -t 'blog':2 'zsh' C-m



tmux select-window -t 'blog':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'blog'
else
    tmux -u switch-client -t 'blog'
fi

_TMUX=$TMUX
TMUX=
cd ~/data/workspace/ornicar.github.com
tmux start-server

if ! $(tmux has-session -t blog); then

tmux set-option base-index 1
tmux new-session -d -s blog -n vim


  

  
tmux new-window -t blog:2 -n blog
  



tmux send-keys  -t blog:1 'vim' C-m

tmux send-keys  -t blog:2 'zsh' C-m


tmux select-window -t blog:1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t blog
else
    tmux -u switch-client -t blog
fi

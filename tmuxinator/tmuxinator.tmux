cd ~/data/workspace/tmuxinator
tmux start-server

if ! $(tmux has-session -t tmuxinator); then

tmux set-option base-index 1
tmux new-session -d -s tmuxinator -n vim


  

  
tmux new-window -t tmuxinator:2 -n tmuxinator
  



tmux send-keys  -t tmuxinator:1 'vim' C-m

tmux send-keys  -t tmuxinator:2 '' C-m


tmux select-window -t tmuxinator:1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t tmuxinator
else
    tmux -u switch-client -t tmuxinator
fi

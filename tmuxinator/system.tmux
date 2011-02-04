cd ~/data/workspace/dotfiles
tmux start-server

if ! $(tmux has-session -t system); then

tmux set-option base-index 1
tmux new-session -d -s system -n vim


  

  
tmux new-window -t system:2 -n dotfiles
  

  
tmux new-window -t system:3 -n /etc
  

  
tmux new-window -t system:4 -n system
  



tmux send-keys  -t system:1 'vim' C-m

tmux send-keys  -t system:2 '' C-m

tmux send-keys  -t system:3 'cd /etc' C-m

tmux send-keys  -t system:4 'cd /' C-m


tmux select-window -t system:1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t system
else
    tmux -u switch-client -t system
fi

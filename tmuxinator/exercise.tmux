cd ~/data/workspace/exercise
tmux start-server

if ! $(tmux has-session -t exercise); then

tmux set-option base-index 1
tmux new-session -d -s exercise -n vim


  

  
tmux new-window -t exercise:2 -n exercise
  



tmux send-keys  -t exercise:1 'vim' C-m

tmux send-keys  -t exercise:2 'tig' C-m


tmux select-window -t exercise:1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t exercise
else
    tmux -u switch-client -t exercise
fi

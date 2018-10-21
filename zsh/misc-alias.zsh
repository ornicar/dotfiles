# Go back 3 times
alias ....='cd ../../..'

# Propagate user config
alias _='sudo -E'

# A better ls https://the.exa.website/
alias ls='exa'

# List directory contents
alias l='ls -la'

# Sort dirs by weight
alias ducks='du -lcks * | sort -rn|head -20'

# History alias
alias h='history'

# Add suffix alias for less
alias -g L='| less'

# Vim
alias v="nvim"

# Ranger
alias r="ranger"

# Extract anything
alias x="dtrx"

# Resource this file
alias reload=". ~/.zshrc"

# radios are in ~/radio
alias radio="mplayer -playlist"

alias meteo="curl -4 http://wttr.in/Paris"

# Read 32GB zero's and throw them away.
alias benchmark='\dd if=/dev/zero of=/dev/null bs=1M count=32768'

# Soooo lazy
alias ya='yaourt'

# Generate haskell tags
alias htags='find ./ -name "*.*hs" | xargs hasktags'

alias halt="echo 'Use poweroff instead'"

alias sc2='ulimit -n 8192 && ~/.wine/drive_c/Program\ Files\ \(x86\)/StarCraft\ II/Support64/SC2Switcher_x64.exe'

alias wifi='nmcli -f name,ssid,bssid,chan,rate,signal,bars,security,device,active,in-use dev wifi'

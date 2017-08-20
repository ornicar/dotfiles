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

# Run IM program
alias im="weechat-curses"

# radios are in ~/radio
alias radio="mplayer -playlist"

# Search using surfraw
alias gg="surfraw google"
alias dd="surfraw duckduckgo"
alias urban="surfraw urban"
alias search-acronym="surfraw acronym"

alias meteo="curl -4 http://wttr.in/Paris"

# Read 32GB zero's and throw them away.
alias benchmark='\dd if=/dev/zero of=/dev/null bs=1M count=32768'

# Connect using 3G usb dialer
alias dial='sudo wvdial'

# Soooo lazy
alias ya='yaourt'

# Generate haskell tags
alias htags='find ./ -name "*.*hs" | xargs hasktags'

# Translations
alias trans=google-translate
alias enfr="google-translate en fr "
alias fren="google-translate fr en "

alias halt="echo 'Use poweroff instead'"

alias vimjsx='vim -S ~/dotfiles/vim/jsx.vim'

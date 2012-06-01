# Go back 3 times
alias ....='cd ../../..'

# Sort dirs by weight
alias ducks='du -cks * | sort -rn|head -20'

# History alias
alias h='history'

# Add suffix alias for less
alias -g L='| less'

# Vim
alias v="vim"

# Ranger
alias r="ranger"

# AlsaMixer
alias a="alsamixer"

# PHPUnit
alias phpunituntil="phpunit --stop-on-failure --stop-on-error"

# Resource this file
alias reload=". ~/.zshrc"

# Start web server
alias startwebserver="sudo /etc/rc.d/nginx start && sudo /etc/rc.d/php-fpm start && sudo /etc/rc.d/mongodb start && sudo /etc/rc.d/redis start"
# Stop web server
alias stopwebserver="sudo /etc/rc.d/nginx stop && sudo /etc/rc.d/php-fpm stop && sudo /etc/rc.d/mongodb stop && sudo /etc/rc.d/redis stop"
# Restart web server
alias restartwebserver="sudo /etc/rc.d/nginx restart && sudo /etc/rc.d/php-fpm restart && sudo /etc/rc.d/mongodb restart && sudo /etc/rc.d/redis restart"

alias start="sudo rc.d start"
alias restart="sudo rc.d restart"
alias stop="sudo rc.d stop"

# Run IM program
alias im="weechat-curses"

# radios are in ~/data/radio
alias radio="mplayer -playlist"

# Search using surfraw
alias gg="surfraw google"
alias dd="surfraw duckduckgo"
alias urban="surfraw urban"
alias search-acronym="surfraw acronym"

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

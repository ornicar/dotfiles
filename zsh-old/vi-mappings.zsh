#!/usr/bin/env zsh

# Allow command line editing in an external editor.
autoload -Uz edit-command-line

# This comes from the vi-mode plugin
function zle-line-init {
  zle reset-prompt
}

zle -N zle-line-init
zle -N edit-command-line

# Avoid binding ^J, ^M,  ^C, ^?, ^S, ^Q, etc.
bindkey -d # Reset to default.
bindkey -v # Use vi key bindings.
bindkey -M vicmd v edit-command-line # ESC-v to edit in an external editor.

# Vi mappings adapted to colemak layout
bindkey ' ' magic-space 
bindkey -M vicmd "gg" beginning-of-history
bindkey -M vicmd "G" end-of-history
bindkey -M vicmd "e" history-search-backward
bindkey -M vicmd "n" history-search-forward
bindkey -M vicmd "?" history-incremental-search-backward
bindkey -M vicmd "/" history-incremental-search-forward
bindkey -M viins "^L" clear-screen
bindkey -M viins "^W" backward-kill-word
bindkey -M viins "^A" beginning-of-line
bindkey -M viins "^E" end-of-line

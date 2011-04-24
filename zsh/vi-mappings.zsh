#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
#
# There are my zsh vi mappings, optimized for the colemak keyboard layout

# Allow command line editing in an external editor.
autoload -Uz edit-command-line

# This comes from the vi-mode plugin
function zle-line-init {
  zle reset-prompt
}

# If I am using vi keys, I want to know what mode I'm currently using.
# zle-keymap-select is executed every time KEYMAP changes.
# From http://zshwiki.org/home/examples/zlewidgets
rprompt_cached=$RPROMPT
function zle-line-init zle-keymap-select {
  RPROMPT="${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/$rprompt_cached}"
  zle reset-prompt
}

# Accept RETURN in vi command mode.
function accept_line {
  RPROMPT=$rprompt_cached
  builtin zle .accept-line
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N accept_line
zle -N edit-command-line

# Avoid binding ^J, ^M,  ^C, ^?, ^S, ^Q, etc.
bindkey -d # Reset to default.
bindkey -v # Use vi key bindings.
bindkey -M vicmd "^M" accept_line # Alow RETURN in vi command.
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

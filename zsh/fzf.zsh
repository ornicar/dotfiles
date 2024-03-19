#!/usr/bin/env zsh

export FZF_DEFAULT_COMMAND='ag --silent --hidden --skip-vcs-ignores --nocolor --ignore .git --ignore .bloop --ignore node_modules --ignore target --ignore .cache --ignore venv --ignore .mypy_cache --ignore __pycache__ -g ""'
export FZF_DEFAULT_OPTS='--bind=ctrl-e:up'

export FZF_COMPLETION_TRIGGER='..'

FD_EXCLUDES='--exclude .git --exclude node_modules --exclude .bloop --exclude target --exclude .cache'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude .git --exclude node_modules --exclude .bloop --exclude target --exclude .cache . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude .git --exclude node_modules . "$1"
}

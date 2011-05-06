returncode="%(?.%{$fg[yellow]%} ⚡ .%{$fg[red]%} ⚡ )"

PROMPT='${returncode}%{$fg_bold[cyan]%}%C$(git_prompt_info)%{$reset_color%} %'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$reset_color%}±(%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
MODE_INDICATOR="%{$fg[yellow]%}<VI>%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$reset_color%}%{$fg[cyan]%} "

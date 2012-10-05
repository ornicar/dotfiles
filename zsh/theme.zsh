ZSH_THEME_GIT_PROMPT_PREFIX=" %{$reset_color%}±(%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
MODE_INDICATOR="%{$fg[yellow]%}<VI>%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$reset_color%}%{$fg[cyan]%} "

my_git_prompt_info() {
  [ ! -f .git/HEAD ] && return
  ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="*detached*"
  if [ -f .git/BISECT_START ]; then bisect="*bisect*"; else bisect=""; fi
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_prompt_short_sha)$bisect$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

returncode="%(?.%{$fg[yellow]%} λ .%{$fg[red]%} λ )"

PROMPT='${returncode}%{$fg_bold[cyan]%}%C$(my_git_prompt_info)%{$reset_color%} %'

MODE_INDICATOR="%{$fg[yellow]%}<VI>%{$reset_color%} "
USER_NAME=$(whoami)
[ $USER_NAME = "thib" ] && USER_NAME=""

my_git_prompt_info() {
  ref=$(cat .git/HEAD 2> /dev/null) || return
  branch=${ref#ref: refs/heads/} 
  SHA=$(cat .git/refs/heads/$branch 2> /dev/null)
  if [ -z $SHA ]; then
    SHA=$branch
    branch="*detached*"
  fi
  if [ -f .git/BISECT_START ]; then bisect=" *bisect*"; else bisect=""; fi
  echo " %{$reset_color%}±(%{$fg[green]%}$branch %{$fg[cyan]%}$SHA[1,5]%{$reset_color%}$bisect%{$reset_color%})"
}

PROMPT='%(?.%{$fg[yellow]%}$USER_NAME ▸ .%{$fg[red]%} ▸ )%{$fg_bold[cyan]%}%C$(my_git_prompt_info)%{$reset_color%} %'

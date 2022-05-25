# ZSH Theme emulating the Fish shell's default prompt.

_fishy_collapsed_wd() {
  local i pwd
  pwd=("${(s:/:)PWD/#$HOME/~}")
  if (( $#pwd > 1 )); then
    for i in {1..$(($#pwd-1))}; do
      if [[ "$pwd[$i]" = .* ]]; then
        pwd[$i]="${${pwd[$i]}[1,2]}"
      else
        pwd[$i]="${${pwd[$i]}[1]}"
      fi
    done
  fi
  echo "${(j:/:)pwd}"
}

if [[ $terminfo[colors] -ge 256 ]]; then
    blue="%F{81}"
    green="%F{42}"
    orange="%F{209}"
    purple="%F{135}"
    red="%F{197}"
    limegreen="%F{118}"
    magenta="%F{171}"
    reset_color="%F{15}"
else
    blue="%F{blue}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    red="%F{red}"
    green="%F{green}"
fi

local user_color='green'; [ $UID -eq 0 ] && user_color='red'
PROMPT='%n $(_fishy_collapsed_wd)\
%{$orange%}$(git_prompt_info)$(git_prompt_status)%{$reset_color%} \
%{$green%}\
%(!.#.$)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

local return_status="%{$red%}%(?..%?)%{$reset_color%}"
RPROMPT="${RPROMPT}"'${return_status}'

ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$green%} +"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$blue%} !"
ZSH_THEME_GIT_PROMPT_DELETED="%{$red%} -"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%} >"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%} #"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ?"

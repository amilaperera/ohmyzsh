# Custom prompt

setopt promptsubst # sets the PROMPT_SUBST option enabled

# Prepare main prompt
local paren_open="("
local paren_close=")"

# we capitalize SUPERUSER. Therefore use $USERNAME variable rather than using %n
local username=$USERNAME
local user="%(!,%{$fg_bold[red]%}${username:u},%{$fg_bold[white]%}${username})%{$reset_color%}" # username
local host="%{$fg_bold[magenta]%}%m%{$reset_color%}" # host name
local wkp="%{$fg_bold[yellow]%}%~%f%{$reset_color%}" # working path

# username@hostname:wkp
user_host_path="${paren_open}${user}%{$fg_bold[cyan]%}@${host}%{$fg_bold[cyan]%}:${wkp}${paren_close}"
# history number
hist_no="${paren_open}%{$fg_bold[blue]%}%h%f%{$reset_color%}${paren_close}"
# return status of the last command
last_status="${paren_open}%(?,%{$fg[green]%}✓%{$reset_color%},%{$fg[red]%}✗%{$reset_color%})${paren_close}"

# main prompt
PROMPT='┌─${last_status}─${user_host_path}$(git_prompt_info)$(git_remote_status)
└─${hist_no} %# '

ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_DETAILED=" "
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}─${paren_open}%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}${paren_close}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE_COLOR="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" ↓"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE_COLOR="%{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" ↑"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg_bold[magenta]%}↕%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_PREFIX="%{$reset_color%}─${paren_open}%{$fg_bold[grey]%}"
ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_SUFFIX="%{$reset_color%}${paren_close}"

# prompt - PS2
PROMPT2="%B%F{8}Continue%f%b : "

# Prepare RPROMPT
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

# ssh status
function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%{$fg_bold[red]%}(%{$fg_bold[green]%}ssh%{$fg_bold[red]%})%{$reset_color%}"
  fi
}

# build rprompt
function rprompt_info() {
  # docker info
  local docker_info=""
  if [[ -n $DOCKER_MACHINE ]]; then
    docker_info="%{$fg_bold[red]%}(docker:%{$fg_bold[green]%}$DOCKER_MACHINE%{$fg_bold[red]%})%{$reset_color%}"
  fi
  # vi mode, docker, ssh
  echo "$(vi_mode_prompt_info) $docker_info$(ssh_connection)"
}

unset open close
unset username user host wkp

RPROMPT="\$(rprompt_info)"


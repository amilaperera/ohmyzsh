# Custom prompt

setopt promptsubst # sets the PROMPT_SUBST option enabled

# Prepare main prompt
local op="("
local cp=")"

# we capitalize SUPERUSER. Therefore use $USERNAME variable rather than using %n
username=$USERNAME
user="%(!,%{$fg_bold[red]%}${username:u},%{$fg_bold[white]%}${username})%{$reset_color%}" # username
local host="%{$fg_bold[magenta]%}%m%{$reset_color%}" # host name
local wkp="%{$fg_bold[yellow]%}%~%f%{$reset_color%}" # working path

# username@hostname:wkp
local user_host_path="${user}%{$fg_bold[cyan]%}@${host}%{$fg_bold[cyan]%}:${wkp}"

# history number
local hist_no="%{$fg_bold[blue]%}%h%f%{$reset_color%}"
# return status of the last command
local last_status="%(?,%{$fg[green]%}✓%{$reset_color%},%{$fg[red]%}✗%{$reset_color%})"

# main prompt
PROMPT='┌─${op}${last_status}${cp}─${op}${user_host_path}${cp}$(git_prompt_info)
└─${op}${hist_no}${cp}${b} %# '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}─(%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓%{$reset_color%})"

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

RPROMPT="\$(rprompt_info)"


# Custom prompt

setopt promptsubst # sets the PROMPT_SUBST option enabled

# Prepare main prompt
local op="("
local cp=")"
local username=$(whoami)

# user name.
# change in appearance for root and non-root users
local user=
if (( $UID == 0 )); then
    username=`echo $username | tr 'a-z' 'A-Z'`
    user="%{$fg_bold[red]%}${username}%{$reset_color%}"
else
    user="%{$fg_bold[white]%}${username}%{$reset_color%}"
fi
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

# prompt - PS2
PROMPT2="%B%F{8}Continue%f%b : "

# Prepare RPROMP
# ssh connection in prompt
function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%{$fg_bold[red]%}(%{$fg_bold[green]%}ssh%{$fg_bold[red]%})%{$reset_color%}"
  fi
}

# build rprompt
function rprompt_info() {
    local docker_info=""
    local vi_info=""
    local ssh_conn=""
    # docker info
    if [[ -n $DOCKER_MACHINE ]]; then
        docker_info="%{$fg_bold[red]%}(docker:%{$fg_bold[green]%}$DOCKER_MACHINE%{$fg_bold[red]%})%{$reset_color%}"
    fi
    #vi mode info
    vi_info="$(vi_mode_prompt_info)"

    #ssh connection
    ssh_conn="$(ssh_connection)"
    echo "$vi_info $docker_info$ssh_conn"
}
RPROMPT='$(rprompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[blue]%}[%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$fg[blue]%}]"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}]"


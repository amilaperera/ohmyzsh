#############################################################
# Author: Amila Perera
# File Name: ramboda.zsh-theme
#
# My personalized zsh theme.
#############################################################

setopt promptsubst # sets the PROMPT_SUBST option enabled

# The basic prompt extracted from http://tsdh.wordpress.com/2007/12/06/my-funky-zsh-prompt/
# and tweaked according to personal preferece
# For git/svn prompts to work you have to source the oh-my-zsh git/svn plugins and lib/git.zsh

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

# git prompt settings

# the following settings aren't necessary for x86_64, since we use the full blown git_super_status
# from git-prompt plugin.
if [[ "$arch" == armv7* ]]; then
    ZSH_THEME_GIT_PROMPT_PREFIX="─%{$fg[white]%}(%{$fg_bold[white]%}git%{$reset_color%}%{$fg[white]%})%{$reset_color%}─%{$fg[white]%}(%{$fg[cyan]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[white]%})%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}%{ x%G%}"
    ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{ o%G%}"
fi

# git prompt for different architectures.
function git_prompt()
{
    if [[ "$arch" != armv7* ]]; then
        echo "$(git_super_status)"
    else
        echo "$(git_prompt_info)"
    fi
}

# main prompt
# NOTE: git_super_status is taken from git-prompt plugin with little customisation.

# customizing prompt according to the architecture.
# this gives a trimmed down version of the same prompt for tiny architectures like RPi & BBBs.

# Multiline prompts seem buggy in latest zsh 5.3.1 - tab completion eats the last line at least in
# fedora 26
PROMPT='┌─${op}${last_status}${cp}─${op}${user_host_path}${cp}$(git_prompt)
└─${op}${hist_no}${cp}${b} %# '

# A trimmed down single line prompt
# PROMPT='${op}${hist_no}${cp}─${op}${last_status}${cp}─${op}${user_host_path}${cp}$(git_prompt) %# '

# prompt - PS2
PROMPT2="%B%F{8}Continue%f%b : "

# ssh connection in prompt
function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%{$fg_bold[red]%}(%{$fg_bold[green]%}ssh%{$fg_bold[red]%})%{$reset_color%}"
  fi
}

# build rprompt
function rprompt_info()
{
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



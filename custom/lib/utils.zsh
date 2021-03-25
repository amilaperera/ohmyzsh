#!/bin/zsh

# defining zsh true/false {{{
zsh_true=0
zsh_false=1
# }}}

# regular colors {{{
zsh_red_color="\033[0;31m"
zsh_green_color="\033[0;32m"
zsh_yellow_color="\033[0;33m"
zsh_blue_color="\033[0;34m"

zsh_bold_red_color="\033[1;31m"
zsh_bold_green_color="\033[1;32m"
zsh_bold_yellow_color="\033[1;33m"
zsh_bold_blue_color="\033[1;34m"

zsh_reset_color="\033[0m"
# }}}

# echo in red color {{{
function _echo_red()
{
	echo -e $zsh_red_color"$@"$zsh_reset_color
}
# }}}

# echo in green color {{{
function _echo_green()
{
	echo -e $zsh_green_color"$@"$zsh_reset_color
}
# }}}

# echo in yellow color {{{
function _echo_yellow()
{
	echo -e $zsh_yellow_color"$@"$zsh_reset_color
}
# }}}

# echo in blue color {{{
function _echo_blue()
{
	echo -e $zsh_blue_color"$@"$zsh_reset_color
}
# }}}

# outputs console log {{{
function _console_log()
{
	echo '['$(date +'%a %Y-%m-%d %H:%M:%S %z')']' $1
}
# }}}

# prompts the user for confirmation and returns 'y'/'n' {{{
function _confirm()
{
	local answer=''
	local choice=''

	local prompt="confirm [y/n] > "

	until [[ "$choice" = "y" || "$choice" = "n" ]]; do

		read -r "answer?$prompt"
		case "$answer" in
			[yY] ) choice='y';;
			[nN] ) choice='n';;
			* ) ;;
		esac
	done

	[ "$choice" = "y" ] && return $zsh_true || return $zsh_false
}
# }}}

# checks if the current shell is interactive {{{
function _check_for_shell_interactivity()
{
	case "$-" in
		*i* ) return $zsh_true;;
		* ) return $zsh_false;;
	esac
}
# }}}

# checks if command exists {{{
function _command_exists()
{
	if  (($# != 1)) ; then
		echo "_command_exists function should take exactly one argument"
		return $zsh_false
	fi

	type $1 >/dev/null 2>&1
}
# }}}

# get the information of the installed Linux distribution {{{
# NOTE: lsb_release might not work on some versions or
# you might need to install it from the official repos of the
# particular repositories.
function _export_distro_info()
{
	if [[ "$OSTYPE" = linux* ]]; then
		# exporting APT/YUM related variables
		export ZSH_HAS_APT=0
		export ZSH_HAS_YUM=0
		export ZSH_HAS_PACMAN=0

		if _command_exists 'apt-get'; then
			ZSH_HAS_APT=1
		elif _command_exists 'yum'; then
			ZSH_HAS_YUM=1
		elif _command_exists 'pacman'; then
			ZSH_HAS_PACMAN=1
		fi

		# exporting distribution/version related information
		if _command_exists lsb_release; then
			export distroname=$(lsb_release -si) # distro name
			export distrover=$(lsb_release -sr)  # distibution version
			export arch=$(uname -m)              # architecture
		else
			_echo_red "Install lsb_release first"
		fi
	fi
}
# }}}

# source a file if it exists & readable {{{
function _source_if_possible()
{
	if [[ -r $1 ]]; then
		source $1
	fi
}
# }}}

# is_tmux() {{{
# check if we're in a tmux session or not
function _is_tmux()
{
	[[ -n $TMUX ]] && return $zsh_true || return $zsh_false
}
# }}}


# color_codes() {{{
# display ansi color combinations
# hacked from http://www.pixelbeat.org/docs/terminal_colours/
function color_codes()
{
	e="\033["
	vline=$(tput smacs 2>/dev/null; printf 'x'; tput rmacs 2>/dev/null)
	[ "$vline" = "x" ] && vline="|"

	#printf "${e}4m%80s${e}0m\n"
	printf "${e}1;4mf\\\\b${e}0m${e}4m none  white    black     red    green    yellow   blue    magenta    cyan  ${e}0m\\n"

	rows='brgybmcw'

	for f in 0 7 `seq 6`; do
		no=""; bo=""; p=""
		for b in n 7 0 `seq 6`; do
			co="3$f"; [ $b = n ] || co="$co;4$b"
			no="${no}${e}${co}m  ${p}${co} ${e}0m"
			bo="${bo}${e}1;${co}m${p}1;${co} ${e}0m"
			p=" "
		done
		fc=$(echo $rows | cut -c$((f+1)))
		printf "$fc $vline$no\nb$fc$vline$bo\n"
	done
}
# }}}

# tmux_colors() {{{
# display tmux colors
##################################################################
function tmux_colors()
{
	for i in {0..255}; do
		printf "\x1b[38;5;${i}mcolour${i}\e[0m\n"
	done | less -R
}
# }}}

# bak() {{{
# make backup file(s)
function bak()
{
	local ext="bak"
	if [[ "${1}" == "-o" ]]; then
		shift
		ext="orig"
	fi
	for file in "${@}"; do
		cp -f $file $file"."$ext
	done
}
# }}}

# swap() {{{
# swap two files
function swap()
{
	local tempfile=swaptemp.$$
	mv -f "${1}" "${tempfile}" && mv -f "${2}" "${1}" && mv -f "${tempfile}" "${2}"
}
# }}}

# mcd() {{{
# creates a new directory and cd to it
function mcd()
{
	local dir=
	local mcd_usage="Usage: mcd <mode> directory"

	if (($# == 0 || $# > 2 )); then
		echo "$mcd_usage"
	else
		if [ -n "$2" ]; then
			if [[ -d "$2" ]]; then
				echo "${2} already exists. changing directory"
				dir="$2"
			else
				command mkdir -p -m $1 "$2" && dir="$2"
			fi
		else
			if [ -d "$1" ]; then
				echo "$1 already exists. changing directory"
				dir="$1"
			else
				command mkdir -p "$1" && dir="$1"
			fi
		fi
	fi

	cd "$dir"
}
# }}}

# cl() {{{
# cd and list
function cl()
{
	if (( $# == 0 )); then
		# if no argument is supplied, just ls
		command ls -al --color=auto -F -h
	else
		if [[ -d "$1" ]]; then
			# change directory & list the contents
			cd "$1"
			command ls -al --color=auto -F -h
		else
			echo -n "cl: "
			_echo_red "directory($1) doesn't exist"
		fi
	fi
}
# }}}

# tmux_start() {{{
# start tmux session
# NOTE: This function can be called in shell initialization to start
# tmux on start up of the terminal
function tmux_start()
{
	local session_name=

	(($# == 0))  && session_name="$USER" || session_name=$1

	if _command_exists tmux; then
		if [[ "$TERM" != "screen-256color" ]]; then
			tmux attach-session -t "$session_name"
			if (($? != 0)); then
				# if a $session_name named tmux session doesn't exist,
				# then create a new session
				tmux new-session -s "$session_name" -d # first create in detached mode
				tmux attach-session # attach the session
			fi
		fi
	fi
}
# }}}

# ghc() {{{
# github clone
function ghc()
{
	if [[ "${1}" == "-a" ]]; then
		# cloning a repo from personal github account
		shift; git clone https://github.com/amilaperera/"${@}"
	elif [[ "${1}" == "-v" ]]; then
		# cloning a repo from vim-scripts github account
		shift; git clone https://github.com/vim-scripts/"${@}"
	else
		git clone https://github.com/"${@}"
	fi
}
# }}}

# cdf() {{{
# fuzzy cd function
# NOTE: ignore-case does not work with fuzzy cd
function cdf()
{
	cd *$1*
}
# }}}

# calc() {{{
# Trivial command line calculator
function calc()
{
	awk "BEGIN {print \"The answer is : \" $*}";
}
# }}}

# pdf() {{{
# opens acrobat reader
function pdf()
{
	acroread "${@}" 2>/dev/null &
}
# }}}

# diff() {{{
# diff with colordiff
# in order to have bash completion worked properly you may have
# to comment the existing cdiff completion which is hardly used
# refer to /etc/bash_completion file
function cdiff()
{
	colordiff -puw "${@}" | less -R
}
# }}}

# update_os() {{{
# updates the linux OS.
function update_os()
{
	if [[ $ZSH_HAS_APT -eq 1 ]]; then
		_echo_yellow "Identifying Debian based system"
		sudo apt-get update && sudo apt-get upgrade -y
	elif [[ $ZSH_HAS_YUM -eq 1 ]]; then
		_echo_yellow "Identifying RedHat based system"
		sudo yum update -y
	elif [[ $ZSH_HAS_PACMAN -eq 1 ]]; then
		_echo_yellow "Identifying Arch based system"
		sudo pacman -Syu
	else
		_echo_red "Unsupported distribution.."
	fi
}
# }}}

# cmake_insource_clean() {{{
# cleans cmake related files when build in-source built
function cmake_insource_clean()
{
	rm -rf cmake_install.cmake CMakeCache.txt CMakeFiles CMakeLists.txt.user Makefile
}
# }}}

# hig() {{{
# history grep
function hig()
{
	history | grep -i "${@}"
}
# }}}

# htop() {{{
# htop with tmux title change
function htop()
{
	if _is_tmux; then
		local last_window_name=$(tmux display-message -p '#W')
		tmux rename-window "Processes on $HOST" && command htop "$@" && tmux rename-window $last_window_name
	else
		command htop "$@"
	fi
}
# }}}

# path() {{{
# display a formatted path
function path() {
	echo $PATH | tr ":" "\n"
}
# }}}

# givedef() {{{
# find definition of a word
function givedef()
{
	if _command_exists dict; then
		dict -d gcide "$@"
	else
		_echo_red "Install dict program.."
		return 1
	fi
}
# }}}

# setup_ssh_keys() {{{
# convenience for setting up ssh keys
function setup_ssh_keys()
{
	if (($# != 2)); then
		_echo_red "Usage: setup_ssh_keys <user_name> <usage>"
		return 1
	fi

	if [[ -d ~/.ssh/${2} ]]; then
		_echo_red "${2} directory exists under ~/.ssh"
		return 1
	fi

	mkdir -p ~/.ssh/${2}
	if [[ $? -ne 0 ]]; then
		_echo_red "Couldn't create ~/.ssh/${2}"
		return 1
	else
		# generate ssh keys
		ssh-keygen -t rsa -b 4096 -C "$1" -f ~/.ssh/${2}/rsa_key_file
		# adding ssh keys to ssh-agents.
		# NOTE: for this step to be successful, ssh-agent must be started first.
		# This should be handled via .zshrc/.bashrc
		# With oh-my-zsh, simply enable ssh-agent plugin.
		ssh-add ~/.ssh/${2}/rsa_key_file
	fi
}
# }}}

# svn related stuff {{{
#
# svndiff() {{{
# svn diff with colordiff
function svndiff()
{
	svn diff "${@}" | colordiff | less -R
}
# }}}
#
# }}}

# git related stuff {{{
#
# set_url_to_git_ssh() {{{
# NOTE: This supports github/gitlab repositories only.
function use_git_ssh_remote()
{
	local last=`pwd`
	local repo_type=''
	for repo in "${@}"; do
		if [[ ! -d $repo ]]; then
			_echo_red "$repo doesn't exist" && echo && continue
		fi

		cd $repo
		# check if a github repository or not
		git remote -v | command awk '{print $2}' | \
			command grep -Eq '(https://github.com/|git@github.com:)'
		if [[ $? -eq 0 ]]; then
			repo_type='github'
		else
			git remote -v | command awk '{print $2}' | \
				command grep -Eq '(https://gitlab.com/|git@gitlab.com:)'
			if [[ $? -eq 0 ]]; then
				repo_type='gitlab'
			else
				_echo_red "`pwd` - neither a github nor a gitlab repository.."
				cd $last && return 1
			fi
		fi

		_echo_yellow "git repository detected in `pwd`"
		repo_full_name=`git rev-parse --show-toplevel`
		if [[ $? -ne 0 ]]; then
			_echo_red "error getting repo name. Confirm if this is a git repository."
			cd $last && return 1
		fi

		# retrieve repo basename
		repo_name=`command git remote -v | head -n 1 | command awk '{print $2}' | command sed 's/.*\///g'`
		if [[ -z $repo_name ]]; then
			_echo_red "error retrieving repository name"
			cd $last && return 1
		fi

		# retrieve username
		remote_url=`git remote -v | head -n 1 | command awk '{print $2}'`
		local user_name=
		if [[ $remote_url =~ https://$repo_type.com/([^/]*)/ ]]; then
			user_name=$match[1]
			cmd="git remote set-url origin git@$repo_type.com:$user_name/$repo_name"
			echo -n "executing : "
			_echo_yellow $cmd
			eval $cmd
		elif [[ $remote_url =~ git@$repo_type.com: ]]; then
			echo "git remote url already in git-ssh format. Nothing to change"
		else
			_echo_red "Error retrieving user name from the url"
			cd $last && return 1
		fi
		echo
	done
	cd $last
}
# }}}

# set_forks_to_git_ssh() {{{
# This sets all the forks in the .fork_sync.json to use git-ssh url and allows
# to push the changes automatically via fork_sync.py script.
function set_forks_to_git_ssh()
{
	use_git_ssh_remote ~/.oh-my-zsh ~/.vim/bundle/vim-colorschemes ~/.vim/bundle/vim-snippets
}
# }}}

# start_clion() {{{
function start_clion()
{
	# assume that you've created a symlink in tools directory
	sh ~/tools/clion.sh &
}
# }}}

# }}}

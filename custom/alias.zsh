# loading math functions
zmodload zsh/mathfunc

# general {{{
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias more='less'
alias h='history'

alias Q='exit'
alias quit='exit'
alias cls='clear'
alias clr='cd ~/ && clear'

alias Z='source ~/.zshrc'

alias sss='sudo shutdown -P now'
alias sssr='sudo reboot'
# }}}

# ls family aliases {{{
ls_options="--color=auto -F -h"
alias ls="ls $ls_options"            # add colors for filetype recognition
alias la="ls $ls_options -Al"        # long list with hidden files
alias ll="ls $ls_options -l"         # long listing
alias lld="ls $ls_options -ld"       # long list of directories
alias lr="ls $ls_options -lR"        # recursive ls
alias lc="ls $ls_options -ltcr"      # sort by and show change time, most recent last
alias lu="ls $ls_options -ltur"      # sort by and show access time, most recent last
alias lk="ls $ls_options -lSr"       # sort by size, biggest last
alias lx="ls $ls_options -lXB"       # sort by extension
alias lm="ls $ls_options -Al | more" # pipe through 'more'
alias lz="ls $ls_options -lZ"        # SELinux contexts
alias ldz="ls $ls_options -ldZ"      # SELinux contexts for a directory
alias tt='tree -C'                   # nice alternative to recursive ls
alias ttl='tree -C | less -R'        # tree with less
alias ttf='tree -C -f | less -R'     # tree with fullpaths
alias ttp='tree -C -p | less -R'     # tree with file permissions
# }}}

# processes {{{
alias p='ps -ef'   # every process on the system
alias pz='ps -efZ' # SELinux contexts
# }}}

# disk usage {{{
alias du='du -kh'
alias dir_size='du -sch'
alias df='df -kTh'
# }}}

# editor {{{
alias e='$VISUAL'       # edit in VISUAL, E is a function to edit in gvim in background
alias view='$VISUAL -R' # opens the file in readonly mode
alias vi='$VISUAL'
# }}}

# linux update {{{
# NOTE: distro identification is not tested for distros other than
# Fedora and Ubuntu
alias U='update_os'
# }}}

# ctags creation for c/c++ programs {{{
alias ct='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q  **/*.(c|cpp|cxx|h)'
# }}}

# encoding conversion {{{
alias nkfeuc='nkf -Lu -e --overwrite' # converts to EUC and overwrites the file
alias nkfutf='nkf -Lu -w --overwrite' # converts to UTF-8 and overwrites the file
# }}}

# build & compiling related {{{
alias mm='make clean && make -j8'
# }}}

# start tmux {{{
alias t='tmux -u'
alias ta='tmux attach-session -t'
alias tk='tmux kill-session -t'
alias tl='tmux list-sessions'
alias ts='tmux_start' # invokes the custom tmux_start function, which creates a session with user name

alias mux='tmuxinator'
# }}}

# ack & silver-searcher aliases {{{
# NOTE: distro identification is not tested for distros other than
# Fedora and Ubuntu
if [[ $distroname == "Ubuntu" ]]; then
	if (( int(distrover) < 17 )); then
		alias ak='ack-grep'
	else
		alias ak='ack'
	fi
else
	alias ak='ack'
fi

# This overrides the ag alias introduced by Ubuntu/Debian plugin in oh-my-zsh.
alias ag='command ag'
alias agp='ag --pager="less -R"'
# }}}

# dmesg helpers {{{
alias dmesg="dmesg --color=always"
alias dmesgL="dmesg --color=always | less -R"
# }}}

# setting global aliases {{{
# hacked from zsh-lovers
alias -g CA="2>&1 | cat -A"
alias -g C='| wc -l'
alias -g D="DISPLAY=:0.0"
alias -g DN=/dev/null
alias -g ED="export DISPLAY=:0.0"
alias -g EG='|& grep'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g ETL='|& tail -20'
alias -g ET='|& tail'
alias -g F=' | fmt -'
alias -g G='| grep'
alias -g H='| head'
alias -g HL='|& head -20'
alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g LL="2>&1 | less"
alias -g L="| less -R"
alias -g LS='| less -S'
alias -g MM='| most'
alias -g M='| more'
alias -g NE="2> /dev/null"
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g PIPE='|'
alias -g RNS='| sort -nr'
alias -g S='| sort'
alias -g TL='| tail -20'
alias -g T='| tail'
alias -g US='| sort -u'
alias -g VM=/var/log/messages
alias -g X0G='| xargs -0 grep'
alias -g X0='| xargs -0'
alias -g XG='| xargs grep'
alias -g X='| xargs'
# }}}

# setting suffix aliases {{{
alias -s c=nvim
alias -s cpp=nvim
alias -s cc=nvim
alias -s h=nvim
alias -s hpp=nvim
alias -s conf=nvim
alias -s txt=nvim
alias -s notes=nvim
# }}}


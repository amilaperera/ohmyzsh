# autoloading {{{
autoload -U zmv
autoload -U zcalc
# }}}

# setting path {{{
typeset -aU path # unique entries for path variable
# nvim when installed from source through `post_install.sh`
path+=('/usr/local/nvim/bin')
path+=('/snap/bin')
# }}}

# setting term colors {{{
[ -z $TMUX ] && export TERM=xterm-256color  # let tmux decide TERM to use,
                                            # otherwise set it to xterm-256color
# }}}

# setting editor {{{
if _command_exists 'nvim'; then
	VISUAL='nvim'
elif _command_exists 'vim'; then
	VISUAL='vim'
else
	VISUAL='vi'
fi
export VISUAL
export EDITOR="$VISUAL"
export SVN_EDITOR="$VISUAL"
export CVS_EDITOR="$VISUAL"
export FCEDIT="$VISUAL"
# }}}

# core dump {{{
ulimit -c unlimited
# }}}


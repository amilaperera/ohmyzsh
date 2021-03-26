# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# custom theme
ZSH_THEME="ramboda"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# git
plugins=(git git-prompt)
# vim/nvim & tmux
plugins+=(tmux tmuxinator vi-mode)
# misc
plugins+=(z extract history-substring-search colored-man-pages)
# custom
plugins+=(utils-extras zle-extras)

# Starts oh-my-zsh configuration
source $ZSH/oh-my-zsh.sh


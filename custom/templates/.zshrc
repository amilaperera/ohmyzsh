# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# custom theme
ZSH_THEME="ramboda"

# Since we're working off a fork this is redundant.
# Use fork_sync.py to keep the fork up-to-date with the upstream ohmyzsh repository.
# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

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
plugins=(git)
# vim/nvim & tmux
plugins+=(vi-mode tmux tmuxinator)
# misc
plugins+=(z extract history-substring-search colored-man-pages)
# custom
plugins+=(utils-extras zle-extras)

# ssh settings (only for non-root users)
if [[ ${UID} != 0 ]]; then
  plugins+=(ssh-agent)
  zstyle :omz:plugins:ssh-agent identities id_github_personal
fi

# Starts oh-my-zsh configuration
source $ZSH/oh-my-zsh.sh

# Source local zsh file (environment specific)
local zsh_file=$HOME/.zsh_local
utils::source_if_exists ${zsh_file}


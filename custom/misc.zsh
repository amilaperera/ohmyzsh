# Miscellenous functions

zmodload -i zsh/zutil

# display tmux colors
function tmux_colors() {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\e[0m\n"
  done | less -R
}

# swap two files
function swap() {
  local tempfile=swaptemp.$$
  mv -f "${1}" "${tempfile}" && mv -f "${2}" "${1}" && mv -f "${tempfile}" "${2}"
}

# updates the Linux distro
# update_os (--min|--check) --verbose
function update_os() {
  if [[ $ZSH_HAS_APT -eq 1 ]]; then
    update_os::update_with_apt "${@}"
  elif [[ $ZSH_HAS_DNF -eq 1 ]]; then
    update_os::update_with_dnf "${@}"
  elif [[ $ZSH_HAS_PACMAN -eq 1 ]]; then
    update_os::update_with_pacman "${@}"
  else
    _echo_red "Unsupported distribution!!!"
  fi
}

function update_os::update_with_dnf() {
  _echo_yellow "Identifying RedHat based system"

  zparseopts -D -E -F -min=o_min -check=o_check -verbose=o_verbose
  cmd="sudo dnf -y"
  [[ -n "${o_verbose}" ]] && cmd="${cmd}v"

  if [[ -n "${o_min}" ]]; then
    cmd="${cmd} upgrade-minimal"
  elif [[ -n "${o_check}" ]]; then
    cmd="${cmd} check-upgrade"
  else
    cmd="${cmd} upgrade"
  fi
  print "${cmd}"; eval "${cmd}"
}

function update_os::update_with_apt() {
  _echo_yellow "Identifying Debian based system"
  sudo apt-get update && sudo apt-get upgrade -y
}

function update_os::update_with_pacman() {
  _echo_yellow "Identifying Arch based system"
  sudo pacman -Syu
}

# find dictionary definition of a word
function givedef() {
  if _command_exists dict; then
    dict -d gcide "$@"
  else
    _echo_red "Install dict program.."
    return 1
  fi
}

# convenience for setting up ssh keys
function setup_ssh_keys() {
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


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
    utils::red "Unsupported distribution!!!"
  fi
}

function update_os::update_with_dnf() {
  utils::yellow "Identifying RedHat based system"

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
  utils::yellow "Identifying Debian based system"
  sudo apt-get update && sudo apt-get upgrade -y
}

function update_os::update_with_pacman() {
  utils::yellow "Identifying Arch based system"
  sudo pacman -Syu
}

# find dictionary definition of a word
function givedef() {
  if utils::command_exists dict; then
    dict -d gcide "$@"
  else
    utils::red "Install dict program.."
    return 1
  fi
}

function boost_version() {
  if [[ $ZSH_HAS_DNF -eq 1 ]]; then
    dnf info --installed boost | grep 'Version'
  fi
}


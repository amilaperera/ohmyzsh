#!/bin/zsh

# This contains utility functions that are used by other custom scripts.
# Finally this exports the Linux distribution related information

# defining zsh true/false
zsh_true=0
zsh_false=1

# regular colors
zsh_red_color="\033[0;31m"
zsh_green_color="\033[0;32m"
zsh_yellow_color="\033[0;33m"
zsh_blue_color="\033[0;34m"

zsh_bold_red_color="\033[1;31m"
zsh_bold_green_color="\033[1;32m"
zsh_bold_yellow_color="\033[1;33m"
zsh_bold_blue_color="\033[1;34m"

zsh_reset_color="\033[0m"

# echo in red color
function utils::red() {
  echo -e $zsh_red_color"$@"$zsh_reset_color
}

# echo in green color
function utils::green() {
  echo -e $zsh_green_color"$@"$zsh_reset_color
}

# echo in yellow color
function utils::yellow() {
  echo -e $zsh_yellow_color"$@"$zsh_reset_color
}

# echo in blue color
function utils::blue() {
  echo -e $zsh_blue_color"$@"$zsh_reset_color
}

# logging
function utils::log() {
  echo '['$(date +'%a %Y-%m-%d %H:%M:%S %z')']' $1
}

# prompts the user for confirmation and returns 'y'/'n'
function utils::confirm() {
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

# checks if the current shell is interactive
function utils::check_for_shell_interactivity() {
  case "$-" in
    *i* ) return $zsh_true;;
    * ) return $zsh_false;;
  esac
}

# checks if command(s) exists
function utils::command_exists() {
  for arg in "${@}"; do
    if ! type $arg >/dev/null 2>&1; then
      return $zsh_false;
    fi
  done
  return $zsh_true;
}

# get the information of the installed Linux distribution
# NOTE: lsb_release might not work on some versions or
# you might need to install it from the official repos of the
# particular repositories.
function utils::export_distro_info() {
  if [[ "$OSTYPE" = linux* ]]; then
    if utils::command_exists 'apt-get'; then
      export ZSH_HAS_APT=1
    elif utils::command_exists 'dnf'; then
      export ZSH_HAS_DNF=1
    elif utils::command_exists 'pacman'; then
      export ZSH_HAS_PACMAN=1
    fi

    # exporting distribution/version related information
    if utils::command_exists lsb_release; then
      export DISTRO_NAME=$(lsb_release -si) # distro name
      export DISTRO_VER=$(lsb_release -sr)  # distibution version
    else
      utils::red "Install lsb_release first"
    fi
  fi
}

# source a file if it exists & readable
function utils::source() {
  if [[ -r $1 ]]; then
    source $1
  fi
}

# check if we're in a tmux session or not
function utils::is_tmux() {
  [[ -n $TMUX ]] && return $zsh_true || return $zsh_false
}

# Eventually export the distribution information
utils::export_distro_info


#!/bin/bash source-this-script

# This script draws heavily from the Homebrew installer script:
#   https://raw.githubusercontent.com/Homebrew/install/master/install.sh

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

# string formatters
if [[ -t 1 ]]; then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_green="$(tty_escape 32)"
tty_blue="$(tty_escape 34)"
tty_default="$(tty_escape 39)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

shell_join() {
  local arg
  printf "%s" "$1"
  shift
  for arg in "$@"; do
    printf " "
    printf "%s" "${arg// /\ }"
  done
}

info() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

title() {
  printf "${tty_green}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

identifier() {
  printf "${tty_green}%s${tty_default}" "$1"
}

installing_feature() {
  title "Installing $(identifier $1)"
}

execute() {
  if ! "$@"; then
    abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
  fi
}

stay_awake_while() {
  caffeinate -dims "$@"
}

quietly_brew_bundle() {
  local brewfile=$1
  shift
  local regex='(^Using )|Homebrew Bundle complete|Skipping install of|It is not currently installed|Verifying SHA-256|==> (Downloading|Purging)|Already downloaded:|No SHA-256'
  stay_awake_while brew bundle install --file="$brewfile" "$@" | (grep -vE "$regex" || true)
}

install_packages() {
  info "Installing or updating Homebrew packages..."
  quietly_brew_bundle /dev/stdin "$@"
}

# Search given executable in PATH (remove dependency for `which` command)
which() {
  # Alias to Bash built-in command `type -P`
  type -P "$@"
}

is_command() {
  command -v "$1" >/dev/null
}

require_homebrew() {
  if ! is_command brew; then
    abort "This script requires Homebrew, which was not found in your PATH"
  fi
}

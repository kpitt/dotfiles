#!/bin/bash

# This script draws heavily from the Homebrew installer script:
#   https://raw.githubusercontent.com/Homebrew/install/master/install.sh

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

# Single brackets are required here for POSIX compatibility
# until we know we are running in `bash`.
if [ -z "${BASH_VERSION:-}" ]
then
  abort "Bash is required to interpret this script."
fi

# string formatters
if [[ -t 1 ]]; then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_blue="$(tty_mkbold 34)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

info() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$1"
}

is_command() {
  command -v "$1" > /dev/null
}

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

if ! is_command brew; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  # Check the location of the `brew` command because install path is
  # different for Apple Silicon.
  BREW_COMMAND=/usr/local/bin/brew
  if ! is_command $BREW_COMMAND; then
    BREW_COMMAND=/opt/homebrew/bin/brew
  fi
  # Make sure Homebrew is in the path.
  eval "$($BREW_COMMAND shellenv)"
else
  info "Homebrew is already installed"
fi

info "Installing required Homebrew packages..."
brew tap homebrew/bundle
( brew bundle --no-lock --file=/dev/stdin --verbose || true ) <<EOB
cask "1password"
cask "1password-cli"
brew "age"
brew "chezmoi"
EOB

info "Success!"
echo

info "Next steps:"
cat <<EOS
- Open the 1Password app and sign in.
- Go to "Preferences > Advanced" and enable the following options:
    [x] Use the SSH agent
    [x] Biometric unlock for 1Password CLI
- Further documentation:
    ${tty_underline}https://github.com/kpitt/dotfiles/blob/chezmoi/README.md${tty_reset}

EOS

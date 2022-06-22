#!/bin/bash
set -eo pipefail

info() {
  tput setaf 2
  echo "=== $*"
  tput sgr0
}

command_does_not_exist(){
  ! command -v "$1" > /dev/null
}

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

info "Checking for Homebrew..."
if command_does_not_exist brew; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  # Check the location of the `brew` command because install path is
  # different for Apple Silicon.
  BREW_COMMAND=/usr/local/bin/brew
  if command_does_not_exist $BREW_COMMAND; then
    BREW_COMMAND=/opt/homebrew/bin/brew
  fi
  # Make sure Homebrew is in the path.
  eval "$($BREW_COMMAND shellenv)"
else
  info "Homebrew is already installed"
fi

info "Installing base Homebrew packages..."
brew tap homebrew/bundle
( brew bundle --no-lock --file=/dev/stdin --verbose || true ) <<EOB
cask "1password"
cask "1password-cli"
brew "age"
brew "chezmoi"
EOB

info "Success!"

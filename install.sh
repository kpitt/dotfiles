#!/bin/bash
# vim: tw=0

# Ensure that we are in the dotfiles directory.
cd $(dirname $0)
DOTFILES_ROOT=$(pwd)

set -eo pipefail

color() {
  local colornumber="$1"
  shift
  tput setaf "$colornumber"
  echo "$*"
  tput sgr0
}

# blue = 4
# magenta = 5
red(){ color 1 "$*"; }
green(){ color 2 "$*"; }
yellow(){ color 3 "$*"; }

info(){
  green "=== $@"
}

error(){
  red "!! $@"
}

tags=( $(grep TAGS rcrc | cut -d '"' -f 2) )
tag_dirs=( "${tags[@]/#/tag-}" )

# Generates a list of files in enabled tag directories.
# Use with command substitution: $(tagged filename)
tagged(){
  for f in ${tag_dirs[@]/%//$1}; do
    if [[ -f "$f" ]]; then
      echo "$f"
    fi
  done
}

stay_awake_while(){
  caffeinate -dims "$@"
}

quietly_brew_bundle(){
  local brewfile=$1
  shift
  local regex='(^Using )|Homebrew Bundle complete|Skipping install of|It is not currently installed|Verifying SHA-256|==> (Downloading|Purging)|Already downloaded:|No SHA-256'
  stay_awake_while brew bundle --no-lock --file="$brewfile" "$@" | (grep -vE "$regex" || true)
}

command_does_not_exist(){
  ! command -v "$1" > /dev/null
}

info "Checking for command-line tools..."
if command_does_not_exist xcodebuild; then
  stay_awake_while xcode-select --install
fi

# Ensure that Homebrew doesn't send analytics during install.
export HOMEBREW_NO_ANALYTICS=1
# Don't show environment hints during install.
export HOMEBREW_NO_ENV_HINTS=1

info "Installing Homebrew (if not already installed)..."
if command_does_not_exist brew; then
  stay_awake_while /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  # Check the location of the `brew` command because install path is
  # different for Apple Silicon.
  BREW_COMMAND=/usr/local/bin/brew
  if command_does_not_exist $BREW_COMMAND; then
    BREW_COMMAND=/opt/homebrew/bin/brew
  fi
  # Make sure Homebrew is in the path.
  eval "$($BREW_COMMAND shellenv)"
fi

info "Installing Homebrew packages..."
brew tap homebrew/bundle
quietly_brew_bundle Brewfile --verbose
# Brewfile.casks exits 1 sometimes but didn't actually fail
quietly_brew_bundle Brewfile.casks || true

if ! echo "$SHELL" | grep -Fq zsh; then
  info "Your shell is not Zsh. Changing it to Zsh..."
  chsh -s /bin/zsh
fi

info "Linking dotfiles into ~..."
# Before `rcup` runs, there is no ~/.rcrc, so we must tell `rcup` where to look.
export RCRC=rcrc
stay_awake_while rcup -d .

stay_awake_while ./system/osx-settings

green "== Success!"

yellow "== Post-install instructions =="
yellow "You must log out and back in for updated settings to take effect"
yellow "before proceeding with manual installation steps."

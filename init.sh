#!/usr/bin/env zsh
cd $(dirname $0)
DOTFILES_ROOT=$(pwd)
print "Dotfiles directory: $DOTFILES_ROOT"

set -e

RCRC=rcrc rcup -v

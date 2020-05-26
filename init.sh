#!/usr/bin/env zsh
cd $(dirname $0)
DOTFILES_ROOT=$(pwd)
print "Dotfiles directory: $DOTFILES_ROOT"

set -e

link_file () {
    local src="$DOTFILES_ROOT/$1" dst="$HOME/${2:-.$1}"

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
    then
        print "File already exists: $dst -> $src"
    else
        ln -s "$src" "$dst"
        print "linked $src to $dst"
    fi
}

# Symlink config files.
link_file "vimrc"
link_file "gvimrc"
link_file "zsh/zshrc" ".zshrc"
# Symlink config directories.
link_file "vim"

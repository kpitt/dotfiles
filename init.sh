#!/usr/bin/env bash
cd $(dirname $0)
DOTFILES_ROOT=$(pwd)
echo $DOTFILES_ROOT

set -e

copy_file () {
    local src=$1 dst=$2

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
    then
        printf "File already exists: $dst -> $src\n"
    else
        cp -p "$src" "$dst"
        printf "copied $src to $dst\n"
    fi
}

link_file () {
    local src=$1 dst=$2

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
    then
        printf "File already exists: $dst -> $src\n"
    else
        src=${src#$HOME/}
        ln -s "$src" "$dst"
        printf "linked $src to $dst\n"
    fi
}

# Copy all config file templates to the correct locations.
for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*-template')
do
    dst="$HOME/.$(basename "${src%-*}")"
    copy_file "$src" "$dst"
done

# Symlink config directories.
link_file "$DOTFILES_ROOT/vim" "$HOME/.vim"

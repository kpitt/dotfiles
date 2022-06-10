# Initialize "rupa/z" cd utility.
if [ -f "$HOMEBREW_PREFIX/etc/profile.d/z.sh" ]; then
    [[ -f "$HOME/.z" ]] || touch "$HOME/.z"
    . "$HOMEBREW_PREFIX/etc/profile.d/z.sh"
fi

# Initialize "gsamokovarov/jump" fuzzy cd utility.
# This is made availabe for evaluation, but is currently not enabled.
# if [ -x "$(command -v jump)" ]; then
#     eval "$(jump shell)"
# fi

# Install `chpwd` hook to update environment.
# When used with P10k instant prompt, this requires `emulate zsh`.
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

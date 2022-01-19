# Prepend user-specific PATH directories, if they exist.
# Each directory is added to the beginning of the path, so
# these should be in reverse order of priority.

# This prevents duplicate entries in $PATH (e.g. from other config scripts).
typeset -U path

# prepend Hombebrew directories to path
PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# add user bin directories if they exist
[[ -d $HOME/.local/bin ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d $HOME/bin ]] && PATH="$HOME/bin:$PATH"

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:$PATH"

# Rust
[[ -r "$HOME"/.cargo/env ]] && source "$HOME"/.cargo/env
alias ci="cargo install --path . --force"

# rbenv
if command -v rbenv &>/dev/null; then
  eval "$(rbenv init - zsh)"
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

export -U PATH

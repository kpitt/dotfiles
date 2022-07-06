# Prepend user-specific PATH directories, if they exist.
# Each directory is added to the beginning of the path, so
# these should be in reverse order of priority.
[[ -d $HOME/.local/bin ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d $HOME/bin ]] && PATH="$HOME/bin:$PATH"

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:$PATH"

# Rust
if [[ -r "$HOME"/.cargo/env ]]; then
  source "$HOME"/.cargo/env
  alias ci="cargo install --path . --force"
fi

# rbenv
if command -v rbenv &>/dev/null; then
  _evalcache rbenv-init rbenv init - zsh
fi

# jenv
if command -v jenv &>/dev/null; then
  _evalcache jenv-init jenv init - zsh
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

export -U PATH

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

# jenv
if command -v jenv &>/dev/null; then
  # Don't cache "jenv init" script because it wreaks havoc
  # when jenv is upgraded.
  eval "$(jenv init - zsh)"
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

export -U PATH

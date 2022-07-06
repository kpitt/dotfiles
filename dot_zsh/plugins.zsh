# Disable oh-my-zsh "paste-magic" functions for faster paste at command prompt.
DISABLE_MAGIC_FUNCTIONS=true
# Load the oh-my-zsh library
antigen use oh-my-zsh

## Load plugin bundles

# Fish-like syntax highlighting, history suggestions and completions.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen theme romkatv/powerlevel10k

# load extra files in ~/.zsh/plugins
_load_plugins() {
  setopt localoptions extendedglob
  _dir="$1"
  if [ -d "$_dir" ]; then
    for config in "$_dir"/**/*~*.zwc(N-.); do
      . $config
    done
  fi
}
_load_plugins "$HOME/.zsh/plugins"
unset -f _load_plugins

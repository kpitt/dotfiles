## Load the Antigen plugin manager
source ~/.zsh/antigen.zsh

# Disable oh-my-zsh "paste-magic" functions for faster paste at command prompt.
DISABLE_MAGIC_FUNCTIONS=true
# Load the oh-my-zsh library
antigen use oh-my-zsh

## Load plugin bundles

# Fish-like syntax highlighting, history suggestions and completions.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

# Add support for async scripts.
antigen bundle mafredri/zsh-async@main

antigen bundle agkozak/zsh-z

antigen theme romkatv/powerlevel10k

## Tell antigen that we're done
antigen apply

# load extra files in ~/.zsh/plugins
_load_plugins() {
  setopt localoptions extendedglob
  _dir="$HOME/.zsh/plugins"
  if [[ -d "$_dir" ]]; then
    for config in "$_dir"/**/*~*.zwc(N-.); do
      . $config
    done
  fi
}
_load_plugins
unset -f _load_plugins

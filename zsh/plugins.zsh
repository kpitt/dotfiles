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

# Load the SSH agent for git authentication
antigen bundle ssh-agent

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git

## Load the prompt theme
#antigen theme robbyrussell
antigen theme romkatv/powerlevel10k

## Tell antigen that we're done
antigen apply

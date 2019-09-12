## Load the Antigen plugin manager
source ~/.dotfiles/zsh/antigen.zsh

# Load the oh-my-zsh library
antigen use oh-my-zsh

## Load plugin bundles

# Fish-like syntax highlighting, history suggestions and completions.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

# Load the SSH agent for git authentication
antigen bundle ssh-agent

# Easier switching to most-used directories
antigen bundle rupa/z

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git

## Load the prompt theme
#antigen theme robbyrussell
antigen theme romkatv/powerlevel10k

## Tell antigen that we're done
antigen apply

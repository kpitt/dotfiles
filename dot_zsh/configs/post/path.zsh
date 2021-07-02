# Prepend user-specific PATH directories, if they exist.
# Each directory is added to the beginning of the path, so
# these should be in reverse order of priority.
[[ -d $HOME/.local/bin ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d $HOME/bin ]] && PATH="$HOME/bin:$PATH"

# prepend Hombebrew directories to path
PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:$PATH"

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

export -U PATH

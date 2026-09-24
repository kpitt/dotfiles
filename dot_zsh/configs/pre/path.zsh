# Add PATH entries before any other shell initialization is started.
# Use this for entries that might be needed by later configuration steps,
# and that do not have any other dependencies.
#
# NOTE that any path entries added here might be overridden by later
# configuration steps. Use `post/path.zsh` instead for entries that need
# the highest precendence.

# Prepend user-specific PATH directories, if they exist.
# Each directory is added to the beginning of the path, so
# these should be in reverse order of priority.
[[ -d $HOME/.local/bin ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d $HOME/bin ]] && PATH="$HOME/bin:$PATH"

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:$PATH"

export -U PATH

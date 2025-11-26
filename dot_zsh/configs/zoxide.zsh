# Enable zoxide for fuzzy cd matching.
# Use `j` prefix and disable automatic database updates to avoid conflicts
# while evaluating.
if command -v zoxide &>/dev/null; then
  _evalcache zoxide zoxide init --cmd j --hook none zsh

  if [[ -r ~/.z ]]; then
    # Re-import latest `cd` database from `zsh-z`
    zoxide import --merge --from z ~/.z
  fi
fi

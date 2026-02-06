# Enable zoxide for fuzzy cd matching.
if command -v zoxide &>/dev/null; then
  _evalcache zoxide zoxide init zsh
fi

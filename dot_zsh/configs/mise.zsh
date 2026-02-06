# Activate mise-en-place for managing tool versions.
if command -v mise &>/dev/null; then
  _evalcache mise mise activate zsh
fi

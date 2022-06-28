ASDF_PREFIX="$(brew --prefix asdf)"
if [[ ! -z "$ASDF_PREFIX" ]]; then
  if [[ -f "${ASDF_PREFIX}/asdf.sh" ]]; then
    source "${ASDF_PREFIX}/asdf.sh"
    [[ -f ~/.asdf/plugins/java/set-java-home.zsh ]] && source ~/.asdf/plugins/java/set-java-home.zsh
  fi
fi

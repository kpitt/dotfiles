# Select files with `fzf` and pass them to the default editor.
v() {
  local old_IFS=$IFS
  IFS=$'\n'
  local files=($(fzf-tmux --query="$1" --multi --exit-0))
  [[ -n "$files" ]] && ${VISUAL:-vim} "${files[@]}"
  IFS=$old_IFS
}

# Open the default editor and select from recent files.
# Assumes $VISUAL is set to a vim-like editor which has the "fzf.vim" plugin.
vr() {
  ${VISUAL:-vim} -c ":History"
}

chruby_share_dir="$HOMEBREW_PREFIX/opt/chruby/share/chruby"
if [[ -r "$chruby_share_dir/chruby.sh" ]]; then
  source "$chruby_share_dir/chruby.sh"
  source "$chruby_share_dir/auto.sh"
fi

# Homebrew {{{
# Configure Homebrew before the rest of the configuration to ensure that
# all brew-installed utilities are available.

# Opt out of Homebrew analytics.
export HOMEBREW_NO_ANALYTICS=1
# Only run autoupdate once a day.
export HOMEBREW_AUTOUPDATE_SECS=86400
# Use `bat` for the `brew cat` command.
export HOMEBREW_BAT=1
# Disable additional hints about environment config.
export HOMEBREW_NO_ENV_HINTS=1

# Initialize Homebrew depending on Intel or Apple Silicon.
if command -v /opt/homebrew/bin/brew > /dev/null; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Make sure Homebrew-installed completions are on the FPATH.
fpath+="$(brew --prefix)/share/zsh/site-functions"
# }}}

source ~/.zsh/plugins.zsh

# load custom executable functions
for function in ~/.zsh/functions/*(N-.); do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  setopt localoptions extendedglob
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# i   smart case search ala Vim
# R   color
# F   exit if there is less than one page of content
# X   keep content on screen after exit
# M   show more info at the bottom prompt line
# x4  tabs are 4 instead of 8
export LESS=-iRFXMx4
export PAGER=less
export ACK_PAGER=less

[[ -r ~/.rgrc ]] && export RIPGREP_CONFIG_PATH=~/.rgrc

# Local config
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local

# aliases
[[ ! -f ~/.aliases ]] || source ~/.aliases

# vim:foldmethod=marker:foldlevel=1

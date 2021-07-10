source ~/.zsh/plugins.zsh

if [ -x "$(command -v jump)" ]; then
  eval "$(jump shell)"
fi

if [ -f "/usr/local/etc/profile.d/z.sh" ]; then
  . /usr/local/etc/profile.d/z.sh
fi

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
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

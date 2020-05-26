# Load all the init scripts in `~/.profile.d`
for f in ~/.profile.d/*.sh ; do
    if [ -r "$f" ]; then
        source $f
    fi
done

source ~/.zsh/plugins.zsh

export PAGER=less
#
# This affects every invocation of `less`.
#
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x4  tabs are 4 instead of 8
export LESS=-iRFXMx4

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


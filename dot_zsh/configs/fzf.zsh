FZF_HOME=$(brew --prefix)/opt/fzf
if [[ -d $FZF_HOME ]]
then
    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "$FZF_HOME/shell/completion.zsh" 2> /dev/null

    # Key bindings
    # ------------
    source "$FZF_HOME/shell/key-bindings.zsh"
fi

# Note that these FZF options are used by fzf.vim automatically! Yay!
# Use a separate tool to smartly ignore files
export FZF_DEFAULT_COMMAND='rg --hidden --follow --files'
# Jellybeans theme: https://github.com/junegunn/fzf/wiki/Color-schemes
export FZF_DEFAULT_OPTS='--color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
--color info:183,prompt:110,spinner:107,pointer:167,marker:215
--bind ctrl-u:page-up,ctrl-f:page-down
--reverse --height 40%
'

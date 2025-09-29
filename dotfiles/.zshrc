# Should go in to the users home directory (~/).

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/connor/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Zsh functions
# Open a file with fuzzy finder when a directory provided as the first argument
fzof() {
    local dir="${1:-.}"
    xdg-open $(find $dir | fzf) 
}

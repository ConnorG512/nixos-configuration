# Should be copied to user home ( ~/ ).

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
  local file
  file=$(find "$dir" -type f -print0 | fzf --read0)
  [[ -n "$file" ]] && xdg-open "$file"
}

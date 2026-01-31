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
function fzof() {
  local dir="${1:-.}"
  local file
  file=$(find "$dir" -type f -print0 | fzf --read0)
  [[ -n "$file" ]] && xdg-open "$file"
}

function tmuxdev() {
  local SESSION_NAME="Development Workspace"

  if [ -n "$TMUX" ]; then
    tmux attach-session -t $SESSION_NAME 2>/dev/null || echo "Session $SESSION_NAME not found."
    return
  fi
  
  # Create all the windows and applications for the environment.
  if ! tmux has-session -t $SESSION_NAME 2>/dev/null; then
    tmux new-session -d -s $SESSION_NAME -n "Nvim" "nvim"
    tmux new-window -t "$SESSION_NAME" -n "Build"                      # Empty shell
    tmux new-window -t "$SESSION_NAME" -n "Spotify" "spotify_player"
    tmux new-window -t "$SESSION_NAME" -n "Youtube" "youtube-tui"
  else
    echo "Sessions already active, please close current session!"
    return
  fi
  
  # Return to the Neovim window (tmux set up to start at window 1):
  tmux select-window -t $SESSION_NAME:1
  tmux attach-session -t $SESSION_NAME
}

function cdf() {
  local dir="${1:-.}"
  cd "$(fd --type d . $dir | fzf)"
}

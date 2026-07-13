alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

alias q='exit'

alias screen='screen -U'
alias tmux="tmux -2 -f '$XDG_CONFIG_HOME/tmux/tmux.conf'"
alias tmuxa='tmux attach || tmux new-session'

alias v="$EDITOR"
alias vi="$EDITOR"
alias vim="$EDITOR"
alias nvim="$EDITOR"

if [[ "$EDITOR" == nvim ]]; then
  alias vimdiff='nvim -d'
fi

alias ,,='cd ..'
alias ..l='cd .. && ls'
alias :q='exit'
alias cd..='cd ..'
alias mdkir='mkdir'
alias dc='cd'
alias sl='ls'
alias sudp='sudo'

## Replacements
alias ls="eza --color=always"
alias ll="eza -lh --color=always --git"
alias la="eza -lah --color=always --git"
alias tree="eza --tree"

alias cat="bat --style=plain --paging=never"
alias preview="bat --style=numbers,changes,header"

alias find="fd"

mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

tempe () {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}

boop () {
  local last="$?"
  if [[ "$last" == '0' ]]; then
    sfx good
  else
    sfx bad
  fi
  $(exit "$last")
}

git-fworktree () {
  cd "$(git worktree list | fzf | awk '{print $1}')"
}

source "$ZDOTDIR/env.zsh"

source "$ZDOTDIR/options.zsh"

source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/prompt.zsh"

source "$ZDOTDIR/mac.zsh"

if [[ -e "$HOME/.zshrc_local" ]]; then
  source "$HOME/.zshrc_local"
fi
export PATH="$HOME/.local/bin:$PATH"

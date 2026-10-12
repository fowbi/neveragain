source "$ZDOTDIR/env.zsh"

source "$ZDOTDIR/options.zsh"

source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/ai.zsh"

source "$ZDOTDIR/prompt.zsh"

source "$ZDOTDIR/sourcing.zsh"

if [[ -e "$HOME/.zshrc_local" ]]; then
  source "$HOME/.zshrc_local"
fi

if [[ -e "$HOME/.alias" ]]; then
  source "$HOME/.alias"
fi

export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

# pnpm
export PNPM_HOME="/home/tobi/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# opencode
export PATH=/home/tobi/.opencode/bin:$PATH
source /home/tobi/.safe-chain/scripts/init-posix.sh # Safe-chain Zsh initialization script

# Disable auto-title when inside tmux
if [[ -n "$TMUX" ]]; then
    export DISABLE_AUTO_TITLE='true'
fi

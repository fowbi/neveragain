SOBOLE_THEME_MODE=light
ZSH_THEME="sobole"
plugins=(
  git
  docker
  docker-compose
  macos
  zsh-autosuggestions
  fzf
)

source $ZSH/oh-my-zsh.sh

if hash fzf 2>/dev/null; then
  source <(fzf --zsh)
fi

source ~/.zsh/catppuccin_latte-zsh-syntax-highlighting.zsh
#source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

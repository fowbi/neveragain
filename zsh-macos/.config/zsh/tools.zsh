# Modern CLI replacements, shared between zsh-macos and zsh-unix.
# Sourced AFTER oh-my-zsh: OMZ defines its own ls/ll/la aliases and would
# otherwise override these. Every tool is guarded, so a missing one just
# falls back to the classic command.
#
# No --color=always: eza/bat detect when they're piped and drop the escape
# codes, so `ls | grep foo` keeps working.

if hash eza 2>/dev/null; then
  alias ls='eza'
  alias ll='eza -lh --git'
  alias la='eza -lah --git'
  alias tree='eza --tree'
fi

if hash bat 2>/dev/null; then
  alias cat='bat --style=plain --paging=never'
  alias preview='bat --style=numbers,changes,header'
fi

if hash fd 2>/dev/null; then
  alias find='fd'
fi

# z <dir> / zi: jump to frecent directories
if hash zoxide 2>/dev/null; then
  eval "$(zoxide init zsh)"
fi

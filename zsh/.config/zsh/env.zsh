# "global" system stuff

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

if hash getconf 2>/dev/null; then
  PATH="$(getconf PATH)"
fi
prepend() {
  [ -d "$1" ] && PATH="$1:$PATH"
}
prepend '/usr/local/bin'
prepend '/opt/homebrew/bin'
prepend '/opt/homebrew/sbin'
prepend "$HOME/bin"
prepend '/home/linuxbrew/.linuxbrew/bin'
unset prepend
export PATH

if hash nvim 2>/dev/null; then
  export EDITOR=nvim
  export MANPAGER='nvim +Man!'
elif hash vim 2>/dev/null; then
  export EDITOR=vim
else
  export EDITOR=vi
fi
export USE_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

export PAGER=less

# zsh stuff

export HISTFILE="$XDG_CACHE_HOME/.zhistory"
export HISTSIZE=10000
export SAVEHIST=9000

export CLICOLOR=1

export ZLE_RPROMPT_INDENT=0
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
export ZSH_CACHE_DIR="$ZSH/cache"

# commands

export FZF_DEFAULT_COMMAND='
  (
    git ls-tree -r --name-only HEAD ||
    find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
      sed s/^..//
  ) 2> /dev/null'

export GATSBY_TELEMETRY_DISABLED=1

export GPG_TTY="$(tty)"

export GREP_COLORS='mt=00;36'

export HOMEBREW_CLEANUP_MAX_AGE_DAYS=60
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_GITHUB_API=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS="--appdir='$HOME/Applications' --require-sha"

export LESS='--ignore-case --RAW-CONTROL-CHARS --QUIET --quit-if-one-screen'
export LESSHISTFILE='-'
export LESSSECURE=1

export LS_COLORS='di=30;46:tw=30;46:ow=30;46:ex=31:su=31:sg=31:'
export LSCOLORS='xgfxcxcxbxcxcxbxbxxgxg'

export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"

export TIMEFMT=$'\n\e[33m%J\e[0m took \e[35m%E\e[0m'

export ZIPOPT='-9 --recurse-paths -X'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/bin:/usr/local/bin:$PATH

export ZK_NOTEBOOK_DIR="$HOME/Documents/Notes"

# GO
# export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
# export PATH=$PATH:$GOROOT/bin

# other env-like options
umask 077

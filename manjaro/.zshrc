# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# fnm
export PATH=/home/king/.fnm:$PATH
eval "`fnm env`"

export PNPM_HOME="/home/king/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

eval $(keychain --eval -q ~/.ssh/github_rsa ~/.ssh/heroku_rsa)

export BROWSER=/usr/bin/brave

alias ls='exa --icons'
alias cat='bat'
alias grep='rg'
alias cp="cp -i"
alias df="df -h"

export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib

export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
alias lg='lazygit'

export PATH=$PATH:~/go/bin

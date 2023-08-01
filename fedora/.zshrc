# Lines configured by zsh-newuser-install
HISTFILE=/home/king-11/.histfile
HISTSIZE=5000
SAVEHIST=10000
setopt autocd beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/king-11/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH=/home/king-11/.fnm:$PATH
eval "`fnm env`"

export GOPATH=$HOME/.go

export BROWSER=/usr/bin/brave-browser

alias ls='exa --icons'
alias cat='bat'
alias grep='rg'
alias cp="cp -i"
alias df="df -h"
alias ghs="ssh-add $HOME/.ssh/github_rsa &>/dev/null"

bindkey '^[[H' beginning-of-line
bindkey '^[OH' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[OF' end-of-line

eval "$(starship init zsh)"
eval "$(ssh-agent -s)" &>/dev/null
ssh-add $HOME/.ssh/github_rsa &>/dev/null

source ~/.zplug/init.zsh

zplug "plugins/zsh-interactive-cd",   from:oh-my-zsh
zplug "plugins/colored-man-pages",   from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2

zplug load

# pnpm
export PNPM_HOME="/home/king-11/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

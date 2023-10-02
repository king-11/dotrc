# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/king-11/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Linuxbrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# fnm
export PATH="/home/king-11/.local/share/fnm:$PATH"
eval "`fnm env`"

# pnpm
export PNPM_HOME="/home/king-11/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH="/home/king-11/.local/bin:$PATH"

eval "$(ssh-agent -s)" &>/dev/null
ssh-add ~/.ssh/microsoft_rsa &>/dev/null
ssh-add ~/.ssh/github_ed &>/dev/null

alias ls='eza --icons'
alias cat='bat'
alias grep='rg'
alias cp="cp -i"
alias df="duf"
alias du="dust"
alias ps="procs"

GPG_TTY=$(tty)
export GPG_TTY

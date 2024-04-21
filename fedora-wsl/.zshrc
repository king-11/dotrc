
# The following lines were added by compinstall
zstyle :compinstall filename '/home/king-11/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
export HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install

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
ssh-add ~/.ssh/github_ed &>/dev/null

alias ll='eza -la --icons --git'
alias ls='eza --icons'
alias cat='bat'
alias grep='rg'
alias cp="cp -i"
alias top="btm"
alias df="duf"
alias du="dust"
alias ps="procs"
alias diff="difft"
alias sed="sd"
alias find="fd"

GPG_TTY=$(tty)
export GPG_TTY

export DISPLAY=:0
export BROWSER=/usr/bin/wslview

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# zinit plugins
zinit ice wait blockf lucid

# cd
zinit light changyuheng/zsh-interactive-cd

# autosuggestions, trigger precmd hook upon load
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10

# Tab completions
zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# Syntax highlighting
zinit ice wait lucid atinit'zpcompinit; zpcdreplay'
zinit light zdharma/fast-syntax-highlighting

zinit snippet OMZP::colored-man-pages
zinit light spaceship-prompt/spaceship-prompt

# zinit end

# linuxbrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# fzf
eval "$(fzf --zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# golang
export GOPATH=$HOME/.go
export PATH=$PATH:$HOME/.go/bin

# atuin
eval "$(atuin init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# for setting home, end and delete key (cat command without anything press key then ctrl + C)
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

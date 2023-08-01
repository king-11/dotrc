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
eval "$(fnm env)"

export GOPATH=$HOME/.go
export PATH=$PATH:$HOME/.go/bin

export BROWSER=/usr/bin/microsoft-edge

alias ll='exa -la --icons --git'
alias ls='exa --icons'
alias cat='bat'
alias grep='rg'
alias cp="cp -i"
alias docker="podman"
alias top="btm"
alias df="duf"
alias du="dust"
alias ps="procs"

mkc() {
	mkdir $1 && cd $1
}

bindkey '^[[H' beginning-of-line
bindkey '^[OH' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[OF' end-of-line

eval "$(ssh-agent -s)" &>/dev/null
ssh-add $HOME/.ssh/github_rsa &>/dev/null

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

# End of Zinit's installer

# zinit plugins

zinit ice wait blockf lucid
zinit light rupa/z

# cd
zinit ice wait lucid
zinit light changyuheng/zsh-interactive-cd

# Don't bind these keys until ready
bindkey -r '^[[A'
bindkey -r '^[[B'
function __bind_history_keys() {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}

# History substring searching
zinit ice wait lucid atload'__bind_history_keys'
zinit light zsh-users/zsh-history-substring-search

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

zplug "plugins/zsh-interactive-cd",   from:oh-my-zsh
zplug "plugins/colored-man-pages",   from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2

zplug load

# pnpm
export PNPM_HOME="/home/king-11/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

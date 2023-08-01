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

export LOCAL_BIN="/home/king-11/.local/bin"
export PATH="$LOCAL_BIN:$PATH"

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

source /home/king-11/.cargo/env

export JETBRAINS_PATH="/home/king-11/.local/share/JetBrains/Toolbox/scripts"
export PATH="$JETBRAINS_PATH/bin:$PATH"


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# pnpm
export PNPM_HOME="/home/king-11/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# Lines configured by zsh-newuser-install
export HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=10000
setopt autocd beep extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/king11/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# load module and run zprof for finding which operation takes longest
# for i in $(seq 1 10); do time $SHELL -i -c exit; done
# zmodload zsh/zprof

alias ll='eza -lah --icons=always --git --color $@'
alias ls='eza --icons=always --git --color $@'
alias cat='bat'
alias grep='rg'
alias cp="cp -i"
alias top="btm"
alias df="duf"
alias du="dust"
alias ps="procs"
alias diff="difft"
alias find="fd"

mkc() {
	mkdir $1 && cd $1
}

bindkey '^[[H' beginning-of-line
bindkey '^[OH' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[OF' end-of-line

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

# interactive cd
# not needed anymore as we use zoxide
# zinit ice wait lucid
# zinit light changyuheng/zsh-interactive-cd

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

zinit ice from"gh-r" as"command" atload'eval "$(starship init zsh)"'
zinit load starship/starship

# zinit end

# cargo
source /home/king11/.cargo/env

# jetbrains
export JETBRAINS_PATH="/home/king11/.local/share/JetBrains/Toolbox/scripts"
export PATH="$JETBRAINS_PATH/bin:$PATH"

# go
export GOPATH=$HOME/.go
export PATH=$PATH:$HOME/.go/bin

# linuxbrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# fnm
export PATH="/home/king11/.local/share/fnm:$PATH"
eval "`fnm env`"

# pnpm
export PNPM_HOME="/home/king11/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# atuin
eval "$(atuin init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# fzf
eval "$(fzf --zsh)"

export LOCAL_BIN="/home/king11/.local/bin"
export PATH="$LOCAL_BIN:$PATH"
export BROWSER=/usr/bin/brave-browser
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

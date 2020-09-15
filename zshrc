# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
source ~/scripts/zsh-interactive-cd.zsh
source ~/scripts/coloured-man-pages.zsh
source ~/scripts/zsh-autosuggestions.zsh
# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit

for dump in ~/.zcompdump(N.mh+24); do
    compinit
done

compinit -C

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

neofetch --ascii_distro archlinux


export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm_load () { . $NVM_DIR/nvm.sh && . $NVM_DIR/bash_completion; }
alias node='unalias nvm; unalias node; unalias npm; unalias npx; unalias yarn; nvm_load; node $@'
alias npm='unalias nvm; unalias node; unalias npm; unalias npx; unalias yarn; nvm_load; npm $@'
alias nvm='unalias nvm; unalias node; unalias npm; unalias npx; unalias yarn; nvm_load; nvm $@'
alias npx='unalias nvm; unalias node; unalias npm; unalias npx; unalias yarn; nvm_load; npx $@'
alias yarn='unalias nvm; unalias node; unalias npm; unalias npx; unalias yarn; nvm_load; yarn $@'

eval "$(starship init zsh)"

#zmodload zsh/zprof
#set -x

## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt extended_history

## Completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

export EDITOR=/usr/bin/nvim
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

# Source manjaro-zsh-configuration
# if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
#   source /usr/share/zsh/manjaro-zsh-config
# fi

# Use manjaro zsh prompt
#if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#  source /usr/share/zsh/manjaro-zsh-prompt
#fi

# Theming section
autoload -Uz compinit colors zcalc
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;
colors

# Execute code in the background to not affect the current session
{
  # Compile zcompdump, if modified, to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

source ~/scripts/zsh-interactive-cd.zsh
source ~/scripts/zsh-autosuggestions.zsh
source ~/scripts/coloured-man-pages.zsh

## Plugins section: Enable fish style features
# Use syntax highlighting
source ~/scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Offer to install missing package if command is not found
if [[ -r /usr/share/zsh/functions/command-not-found.zsh ]]; then
    source /usr/share/zsh/functions/command-not-found.zsh
    export PKGFILE_PROMPT_INSTALL_MISSING=1
fi

# Set terminal window and tab/icon title
#
# usage: title short_tab_title [long_window_title]
#
# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# Fully supports screen and probably most modern xterm and rxvt
# (In screen, only short_tab_title is used)
function title {
  emulate -L zsh
  setopt prompt_subst

  [[ "$EMACS" == *term* ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  case "$TERM" in
    xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*)
      print -Pn "\e]2;${2:q}\a" # set window name
      print -Pn "\e]1;${1:q}\a" # set tab name
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\" # set screen hardstatus
      ;;
    *)
    # Try to use terminfo to set the title
    # If the feature is available set title
    if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
      echoti tsl
      print -Pn "$1"
      echoti fsl
    fi
      ;;
  esac
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m:%~"

# Runs before showing the prompt
function mzc_termsupport_precmd {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return
  title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

# Runs before executing the command
function mzc_termsupport_preexec {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return

  emulate -L zsh

  # split command into array of arguments
  local -a cmdargs
  cmdargs=("${(z)2}")
  # if running fg, extract the command from the job description
  if [[ "${cmdargs[1]}" = fg ]]; then
    # get the job id from the first argument passed to the fg command
    local job_id jobspec="${cmdargs[2]#%}"
    # logic based on jobs arguments:
    # http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
    # https://www.zsh.org/mla/users/2007/msg00704.html
    case "$jobspec" in
      <->) # %number argument:
        # use the same <number> passed as an argument
        job_id=${jobspec} ;;
      ""|%|+) # empty, %% or %+ argument:
        # use the current job, which appears with a + in $jobstates:
        # suspended:+:5071=suspended (tty output)
        job_id=${(k)jobstates[(r)*:+:*]} ;;
      -) # %- argument:
        # use the previous job, which appears with a - in $jobstates:
        # suspended:-:6493=suspended (signal)
        job_id=${(k)jobstates[(r)*:-:*]} ;;
      [?]*) # %?string argument:
        # use $jobtexts to match for a job whose command *contains* <string>
        job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
      *) # %string argument:
        # use $jobtexts to match for a job whose command *starts with* <string>
        job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
    esac

    # override preexec function arguments with job command
    if [[ -n "${jobtexts[$job_id]}" ]]; then
      1="${jobtexts[$job_id]}"
      2="${jobtexts[$job_id]}"
    fi
  fi

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
  local LINE="${2:gs/%/%%}"

  title '$CMD' '%100>...>$LINE%<<'
}

autoload -U add-zsh-hook
add-zsh-hook precmd mzc_termsupport_precmd
add-zsh-hook preexec mzc_termsupport_preexec

alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# NVM Config

#export NVM_DIR="$HOME/.nvm"
#NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
#NODE_GLOBALS+=(node nvm yarn pnpm)

#_load_nvm() {
#    echo "🚨 NVM not loaded! Loading now..."
#    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#}

#for cmd in "${NODE_GLOBALS[@]}"; do
#    eval "function ${cmd}(){ unset -f ${NODE_GLOBALS[*]}; _load_nvm; unset -f _load_nvm; ${cmd} \$@; }"
#done
#unset cmd NODE_GLOBALS

# NVM not needed anymore use fnm

eval "$(pyenv init -)"

#export PATH="$PATH:$HOME/.poetry/bin"
#fpath=($fpath "/home/king11/.zfunc")

eval $(keychain --eval -q ~/.ssh/github_rsa ~/.ssh/heroku_rsa)

export BROWSER=/usr/bin/brave

#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/king11/.anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/king11/.anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/king11/.anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/king11/.anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

alias ls='exa'
alias cat='bat'
alias grep='rg'

export CHPL_HOME=~/CS/Development/chapel
CHPL_BIN_SUBDIR=`"$CHPL_HOME"/util/chplenv/chpl_bin_subdir.py`
export PATH="$PATH":"$CHPL_HOME/bin/$CHPL_BIN_SUBDIR"
export MANPATH="$MANPATH":"$CHPL_HOME"/man
export CHPL_LLVM=none
export CHPL_TARGET_COMPILER=gnu

eval "$(starship init zsh)"
#zprof
#set +x

# fnm
export PATH=/home/lord/.fnm:$PATH
eval "`fnm env`"

export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

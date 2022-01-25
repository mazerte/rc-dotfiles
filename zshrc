# Set Variables
export DOTFILES="$HOME/dotfiles"

# Change ZSH Options

# Adjust History Variables & Options
[[ -z $HISTFILE ]] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000 # Session Memory Limit
SAVEHIST=4000 # File Memory Limit
setopt histNoStore
setopt extendedHistory
setopt histIgnoreAllDups
unsetopt appendHistory # explicit and unnecessary
setopt incAppendHistoryTime

# Line Editor Options (Completion, Menu, Directory, etc.)
# autoMenu & autoList are on by default
setopt autoCd
setopt globDots

# Create Aliases
alias watch='watch --color ' # https://unix.stackexchange.com/questions/25327/watch-command-alias-expansion
alias ls='exa'
# alias cat='bat'
alias a='exa -laFh --git'
alias trail='<<<${(F)path}'
alias ftrail='<<<${(F)fpath}'
# alias man=batman
alias lp='sudo lsof -i -P | grep LISTEN'

# Write Handy Functions
function mkcd() {
  mkdir -p "$@" && cd "$_";
}

# Use ZSH Plugins
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Customize Prompt(s)
export TERM="xterm-256color"

# Disable completion directory permission verification
ZSH_DISABLE_COMPFIX=true

POWERLEVEL9K_MODE='nerdfont-fontconfig'
POWERLEVEL9K_CONTEXT_TEMPLATE="$USER"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$ "
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="006"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="015"
# POWERLEVEL9K_EXECUTION_TIME_ICON=$'\uFACD'
POWERLEVEL9K_NVM_BACKGROUND="003"
POWERLEVEL9K_NVM_FOREGROUND="000"
# POWERLEVEL9K_NODE_ICON=$'\uE718'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs terraform nvm command_execution_time time)

autoload -U add-zsh-hook

source <(antibody init)
antibody bundle < "$DOTFILES/antibody_plugins"

# Set oh-my-zsh path
plugins=(
  nvm
  aws
  kubectl
  terraform
)
ZSH=$(antibody path ohmyzsh/ohmyzsh)
# source /opt/homebrew/opt/powerlevel9k/powerlevel9k.zsh-theme

ZSH_THEME="powerlevel9k/powerlevel9k"

# Change Key Bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Add "zstyles" for Completions & Other Things
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':plugin:history-search-multi-word' clear-on-cancel 'yes'

# Load "New" Completion System
autoload -Uz compinit && compinit
fpath=($fpath ~/.zsh/completion)


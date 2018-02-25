######################################################
# Key bindings
######################################################

# enable vi-liked key bindings
set -o vi

bind 'TAB: menu-complete'
bind 'set completion-ignore-case on'

######################################################
# Imports
######################################################

# source fzf bash completion
if [[ -e  /usr/local/opt/fzf/shell/completion.bash ]]; then
  source /usr/local/opt/fzf/shell/completion.bash
fi
if [[ -e  /usr/local/opt/fzf/shell/key-bindings.bash ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.bash
fi
# source bash completions from brew packages
for completion in /usr/local/etc/bash_completion.d/*; do
  source $completion
done

######################################################
# Prompt
######################################################

function prompt_right() {
  echo -e "\033[0;00m\\\t\033[0m"
}

function prompt_left() {
  echo -e "\033[0;00m\u@\h:\w\033[0m"
}

function prompt() {
  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
  compensate=5
  PS1=$(printf "%*s\r%s\n\$ " "$(($(tput cols)+${compensate}))" "$(prompt_right)" "$(prompt_left)")
}

PROMPT_COMMAND=prompt

######################################################
# PATHs
######################################################

export PATH=$GEM_HOME/bin:$PATH
export PATH=$HOME/.gem/ruby/2.3.0/bin:$PATH
export PATH=$HOME/.bin/:$PATH
export PATH=$HOME/Works/projects/go/bin:$PATH

if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
  export PATH=$HOME/Library/Android/sdk/emulator:$PATH
fi

######################################################
# EXPORTs
######################################################

export GOPATH=$HOME/Works/projects/go
export VISUAL="nvim"
export EDITOR="nvim"
export GEM_HOME=$HOME/.gem
export GREP_OPTIONS='--color=auto'
export FZF_DEFAULT_OPTS="--height=40% --color=bw --reverse"

if which rg >/dev/null; then
  export FZF_DEFAULT_COMMAND="rg --files --hidden --follow  --glob '!.git/*'"
  export FZF_CTRL_T_COMMAND="rg --files --hidden --follow  --glob '!.git/*'"
else
  export FZF_DEFAULT_COMMAND="\
  find . \
    -not -path \"**/node_modules/**\" \
    -not -path \"**/.git/**\" \
    -not -path \"**/*~\" \
    -type f \
  "
  export FZF_CTRL_T_COMMAND="\
  find . \
    -not -path \"**/node_modules/**\" \
    -not -path \"**/.git/**\" \
    -not -path \"**/*~\" \
    -type f \
  "
fi


######################################################
# History configuration
######################################################

# Increase the size of history maintained by BASH
export HISTFILESIZE=10000
export HISTSIZE=${HISTFILESIZE}
# Use leading space to hide commands from history:
export HISTCONTROL=ignorespace:ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# Ensure syncing (flushing and reloading) of .bash_history with in-memory history:
export PROMPT_COMMAND="history -a; history -c; history -r;${PROMPT_COMMAND}"

######################################################
# Aliases
######################################################

alias gs="git s"
alias ga="git a"
alias gai="git ai"
alias gl="git l"
alias gc="git c"
alias gd="git d"
alias gdc="git dc"
alias gp="git p"

alias yta='youtube-dl -f bestaudio'
alias ytv='youtube-dl -f "bestvideo[height<=720]+bestaudio"'
alias mpa='mpv --no-video'
alias mpv='mpv --ytdl-format="94/95/480p"'

alias ll="ls -lcthr"
alias ls="ls -cthr"
alias l="ls -cthr"
alias ..="cd .."

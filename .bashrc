# set vi key mode
set -o vi

bind 'TAB: menu-complete'
bind 'set completion-ignore-case on'

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

export PATH=/Users/$USER/Library/Android/sdk/platform-tools:$PATH
export PATH=/Users/$USER/Library/Android/sdk/emulator:$PATH
export PATH=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home/bin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=~/.bin/:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
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

export VISUAL="nvim"
export EDITOR="nvim"

# Increase the size of history maintained by BASH
export HISTFILESIZE=10000
export HISTSIZE=${HISTFILESIZE}
# Use leading space to hide commands from history:
export HISTCONTROL=ignorespace:ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# Ensure syncing (flushing and reloading) of .bash_history with in-memory history:
export PROMPT_COMMAND="history -a; history -c; history -r;${PROMPT_COMMAND}"

# Golang workspace
export GOPATH=$HOME/Works/projects/go
export PATH=$HOME/Works/projects/go/bin:$PATH

alias gs="git status -s"
alias ga="git add"
alias gai="git add -i -p"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset' --abbrev-commit --date=relative"
alias gc="git commit -v"
alias gd="git diff -w"
alias gdt="git difftool"
alias gdc="git diff --cached -w"
alias gp="git push"

alias yta='youtube-dl -f bestaudio'
alias ytv='youtube-dl -f "bestvideo[height<=720]+bestaudio"'
alias mpa='mpv --no-video'
alias mpv='mpv --ytdl-format="94/95/480p"'

alias ll="ls -lcthr"
alias ls="ls -cthr"
alias l="ls -cthr"
alias ..="cd .."
alias diff="diff --unified --color"

if [[ -e  /usr/share/fzf/completion.bash ]]; then
  source /usr/share/fzf/completion.bash
fi
if [[ -e  /usr/local/opt/fzf/shell/completion.bash ]]; then
  source /usr/local/opt/fzf/shell/completion.bash
fi
if [[ -e  /usr/share/fzf/key-bindings.bash ]]; then
  source /usr/share/fzf/key-bindings.bash
fi
if [[ -e  /usr/local/opt/fzf/shell/key-bindings.bash ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.bash
fi

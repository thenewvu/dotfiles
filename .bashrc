source ~/.bash_prompt

# set vi key mode
set -o vi

export PATH=/home/$USER/.bin:$PATH
export PATH=/home/$USER/.node_modules/bin:$PATH
export PATH=/Users/$USER/Library/Android/sdk/platform-tools:$PATH
export PATH=/Users/$USER/Library/Android/sdk/emulator:$PATH
export PATH=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home/bin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
export VISUAL="nvim"
export EDITOR="nvim"
export FZF_DEFAULT_OPTS="--height=40% --color=bw --reverse"
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob='!.git/*' --glob='!node_modules/*'"
export FZF_CTRL_T_COMMAND="rg --files --hidden --glob='!.git/*' --glob='!node_modules/*'"
export FREETYPE_PROPERTIES="truetype:interpreter-version=38"
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

alias gs="git st"
alias ga="git add"
alias gl="git ls"
alias gc="git commit -v"
alias gd="git diff"
alias gdc="git diff --cached"
alias gp="git push"

alias yc='sudo pacman -Rns $(pacman -Qtdq)'
alias ylt='expac --timefmt="%Y-%m-%d %T" "%l\t%n" | sort | less'
alias ylh='expac -H M "%m\t%n" | sort -h | less'
alias yli='comm -23 <(pacman -Qqt | sort) <(pacman -Qqg base base-devel | sort) | less'

alias ytv='mpv --ytdl-format="94/95/480p"'
alias yta='mpv --no-video --ytdl-format=bestaudio'
alias mpa='mpv --no-video'

alias l="ls -lcthr"
alias ls="ls -lcthr"

alias ..="cd .."

# open a logbook for today
function logbook() {
  nvim ~/Works/logs/$(date '+%Y-%m-%d').md
}

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
if [[ -e  /etc/bash_completion.d/owlman ]]; then
  source /etc/bash_completion.d/owlman
fi

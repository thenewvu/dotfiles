source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash
source /etc/bash_completion.d/owlman
source ~/.bash_prompt

# set vi key mode
set -o vi

export PATH=/home/$USER/.bin:/home/$USER/.node_modules/bin:/Users/$USER/Library/Android/sdk/platform-tools:/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

export VISUAL="nvim"
export EDITOR="nvim"
export FZF_DEFAULT_OPTS="--height=40% --color=bw --reverse"
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob='!.git/*'"
export FZF_CTRL_T_COMMAND="rg --files --hidden --glob='!.git/*'"
export FREETYPE_PROPERTIES="truetype:interpreter-version=38"
# Increase the size of history maintained by BASH
export HISTFILESIZE=10000
export HISTSIZE=${HISTFILESIZE}
# Use leading space to hide commands from history:
export HISTCONTROL=ignorespace
# Ensure syncing (flushing and reloading) of .bash_history with in-memory history:
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"


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

alias mpv='mpv --no-border --geometry=384x216-7-7 --loop-file=inf --ytdl-format="94/95/480p"'
alias mpa='mpv --no-video --loop-file=inf --ytdl-format="bestaudio"'

alias tmux="$(which tmux) attach -t tmux || $(which tmux) new -s tmux"

alias l="ls -lcthr"
alias ls="ls -lcthr"

alias ..="cd .."

# set vi key mode
set -o vi

export PATH=/home/$USER/.bin:/home/$USER/.node_modules/bin:/Users/$USER/Library/Android/sdk/platform-tools:/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

export VISUAL="nvim"
export EDITOR="nvim"
export FZF_DEFAULT_OPTS="--color=bw"
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob='!.git/*'"
export FZF_CTRL_T_COMMAND="rg --files --hidden --glob='!.git/*'"
export FREETYPE_PROPERTIES="truetype:interpreter-version=38"

alias gs="git st"
alias ga="git add"
alias gl="git ls"
alias gc="git commit -v"
alias gd="git diff"
alias gp="git push"
alias gdc="git diff --cached"

alias yc='sudo pacman -Rns $(pacman -Qtdq)'
alias ylt='expac --timefmt="%Y-%m-%d %T" "%l\t%n" | sort | less'
alias ylh='expac -H M "%m\t%n" | sort -h | less'
alias yli='comm -23 <(pacman -Qqt | sort) <(pacman -Qqg base base-devel | sort) | less'

alias mpv-video='mpv --ontop --no-border --geometry=384x216-7-7 --ytdl-format="bestvideo[height<720]+bestaudio/480p"'
alias mpv-audio='mpv --no-video --loop-file=inf --ytdl-format="bestaudio"'

alias tmux="$(which tmux) attach -t tmux || $(which tmux) new -s tmux"

export HH_CONFIG=hicolor         # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
export PROMPT_COMMAND='history -a && history -n && ${PROMPT_COMMAND}'   # mem/file sync
# if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
bind '"\C-r": "\e^ihh \n"'

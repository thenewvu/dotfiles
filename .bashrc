export PATH=$PATH:/home/$USER/.bin:/home/$USER/.node_modules/bin:/Users/$USER/Library/Android/sdk/platform-tools
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

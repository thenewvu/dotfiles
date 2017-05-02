export PATH=$PATH:/home/vu/.bin:/home/vu/.node_modules/bin
export VISUAL="nvim"
export EDITOR="nvim"
export FZF_DEFAULT_OPTS="--color=bw"
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob='!.git/*'"
export FZF_CTRL_T_COMMAND="rg --files --hidden --glob='!.git/*'"

alias gs="git st"
alias ga="git add"
alias gl="git ls"
alias gc="git ci"
alias gd="git diff"
alias gp="git push"
alias gdc="git diff --cached"
alias gco="git checkout"

alias yc="sudo pacman -Rns $(pacman -Qtdq)"

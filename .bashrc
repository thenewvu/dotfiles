# vim:fileencoding=utf-8:foldmethod=marker

shopt -s extglob

# Key mappings {{{

# enable vi-liked key bindings
set -o vi

tabs -4

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

# }}}

# Prompt line {{{

# ref: https://superuser.com/a/517110
function prompt() {
    printf "\e]2;%s\a" "${PWD##*/}"
    PS1=$(printf "\e[40m%*s\r%s\e[0m\n\$ " "$(($(tput cols)-6))" "\t" "\u@\h:\w")
}

PROMPT_COMMAND=prompt

# }}}

# Environment variables {{{

export VISUAL="nvim"
export EDITOR="nvim"

export PATH="$HOME/.bin/:$PATH"

export GOPATH="$HOME/Works/projects/go"
export PATH="$GOPATH/bin:$PATH"

export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:$PATH"
export PATH="$GEM_HOME/ruby/2.3.0/bin:$PATH"

export GREP_OPTIONS='--ignore-case --color=auto'
export CLICOLOR=1

# color highlight for manpage
# https://stealthefish.com/blog/2014/better-bash-man-pages/
export LESS_TERMCAP_mb=$'\E[0;103m' # begin blinking
export LESS_TERMCAP_md=$'\E[0;93m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$(tput bold; tput setaf 8; tput setab 3) # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[04;32m' # begin underline
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

export FZF_COMPLETION_TRIGGER='``'
export FZF_DEFAULT_OPTS="--reverse --color fg:15,hl:10,fg+:-1,bg+:-1,hl+:10,info:15,prompt:9,spinner:15,pointer:9,marker:14,border:15"
export FZF_DEFAULT_COMMAND="rg --files --glob '!**/node_modules/*'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

export ANDROID_HOME="/usr/local/share/android-sdk"
export ANDROID_NDK_HOME="/usr/local/share/android-ndk"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

export FLUTTER_ROOT=~/Works/projects/flutter
export PATH="$FLUTTER_ROOT/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"

# so cmake can find qt
export CMAKE_PREFIX_PATH=/usr/local/opt/qt

# homebrew gnu-sed need below
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# homebrew node@10 need below
export PATH="/usr/local/opt/node@10/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/node@10/lib $LDFLAGS"
export CPPFLAGS="-I/usr/local/opt/node@10/include $CPPFLAGS"

export FFF_OPENER=~/.bin/opener
export FFF_TRASH=~/.Trash

export MAKEFLAGS='-j8 --warn-undefined-variables --no-builtin-rules'

# }}}

# Command history {{{
# https://sanctum.geek.nz/arabesque/better-bash-history/

# Increase the size of history maintained by BASH
export HISTFILESIZE=10000
export HISTSIZE=${HISTFILESIZE}
# ignore recording duplicated or space-leading commands
export HISTCONTROL=ignoreboth:ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# Store multi-line commands in one history entry:
shopt -s cmdhist

# }}}

# Aliases {{{

alias yta='youtube-dl -f bestaudio'
alias ytv='youtube-dl -f "bestvideo[height<=720][ext=webm]+bestaudio[ext=webm]/best" --write-sub --write-auto-sub --sub-lang=en'

alias ll="ls -lcthr"
alias ls="ls -cthr"
alias l="ls -cthr"
alias ..="cd .."

alias mv="mv -i"
alias cp="cp -i"

fzf__git_hash="echo {} | grep -o '[a-f0-9]\{7,\}\$' | head -1"
fzf__git_show="$fzf__git_hash | xargs -I % sh -c 'git show % --color=always | delta -w 200'"
fzf__git_checkout="$fzf__git_hash | xargs -I % sh -c 'git checkout %'"

gl() {
    git log --abbrev-commit --date=relative --color=always            \
            --pretty=format:'%C(auto)%s %C(auto)%d %C(auto)%h%Creset' \
            --no-merges -n 100 "$@" |
        fzf --no-sort --reverse --tiebreak=index --no-multi --ansi    \
            --preview="$fzf__git_show" --preview-window=bottom:80%    \
            --bind "ctrl-y:execute:$fzf__git_hash | pbcopy"           \
            --bind "ctrl-g:execute:$fzf__git_checkout"
}

alias gs="git status --short"
alias gr="git restore -p"
alias gd="git diff --diff-filter=M"
alias ga="git add"
alias gc="git commit -m"

alias ctags="/usr/local/opt/ctags/bin/ctags"

alias dnsflush="sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache"

7z-fast() {
    7z a -t7z -m0=LZMA2:d64k:fb32 -ms=8m -mmt=30 -mx=1 "$1.7z" "$1"
}

7z-slow() {
    7z a -t7z -m0=LZMA2:d64k:fb32 -ms=8m -mmt=30 -mx=9 "$1.7z" "$1"
}

# }}}


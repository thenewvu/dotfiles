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
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

export FZF_COMPLETION_TRIGGER='``'
export FZF_DEFAULT_OPTS="--reverse --color fg:15,hl:10,fg+:-1,bg+:-1,hl+:10,info:15,prompt:9,spinner:15,pointer:9,marker:14,border:15"
export FZF_DEFAULT_COMMAND="rg --files --glob '!**/node_modules/*'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export ANDROID_NDK_HOME="$HOME/Library/Android/ndk/r14b"
export ANDROID_NDK_ROOT="$ANDROID_NDK_HOME"
export ANDROID_NDK_CLANG="$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/darwin-x86_64"
export ANDROID_NDK_ARM="$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64"
export ANDROID_NDK_X86="$ANDROID_NDK_ROOT/toolchains/x86-4.9/prebuilt/darwin-x86_64"
export PATH="$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin:$PATH"
export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"

export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

export FLUTTER_ROOT=~/Works/projects/flutter
export PATH="$FLUTTER_ROOT/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"

# homebrew llvm need below
export PATH="/usr/local/opt/llvm/bin:$PATH"
export CC=clang
export CXX=clang++
export LD=ld.lld
export AR=llvm-ar
export RANLIB=llvm-ranlib
export CFLAGS="$CFLAGS -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
export CCFLAGS="$CCFLAGS -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
export CXXFLAGS="$CXXFLAGS -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
export OBJCFLAGS="$OBJCFLAGS -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
export LDFLAGS="$LDFLAGS -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"

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
# Use one command per line
shopt -s cmdhist

export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

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
fzf__git_show="$fzf__git_hash | xargs -I % sh -c 'git show % --color=always | diff-highlight'"
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
alias gd="git difftool --diff-filter=M"
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


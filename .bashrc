# vim:fileencoding=utf-8:foldmethod=marker

# Key mappings {{{

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

export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:$PATH"
export PATH="$GEM_HOME/ruby/2.3.0/bin:$PATH"

export GREP_OPTIONS='--ignore-case --color=auto'
export CLICOLOR=1

export FZF_COMPLETION_TRIGGER='``'
export FZF_DEFAULT_OPTS="--reverse --ansi --color=16 --color fg:7,hl:2,fg+:7,bg+:-1,hl+:2 --color info:15,prompt:2,spinner:15,pointer:7,marker:7"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow  --glob '!.git/*'"
export FZF_CTRL_T_COMMAND="rg --files --hidden --follow  --glob '!.git/*'"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export ANDROID_NDK_HOME="$HOME/Library/Android/ndk/r14b"
export ANDROID_NDK_ROOT="$ANDROID_NDK_HOME"
export ANDROID_NDK_CLANG="$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/darwin-x86_64"
export ANDROID_NDK_ARM="$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64"
export ANDROID_NDK_X86="$ANDROID_NDK_ROOT/toolchains/x86-4.9/prebuilt/darwin-x86_64"
export PATH="$ANDROID_SDK_ROOT/tools:$PATH"
export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"

export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

export PATH="/usr/local/opt/llvm/bin:$PATH"
export CC=clang
export CXX=clang++
export LD=ld.lld
export AR=llvm-ar
export RANLIB=llvm-ranlib
export CCFLAGS="-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/"
export CXXFLAGS="-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/"
export OBJCFLAGS="-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/"
export LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"

export FFF_OPENER=fff-opener
export FFF_TRASH=~/.Trash

export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# }}}

# Command history {{{

# Increase the size of history maintained by BASH
export HISTFILESIZE=5000
export HISTSIZE=${HISTFILESIZE}
# Use leading space to hide commands from history:
export HISTCONTROL=ignorespace:ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# Ensure syncing (flushing and reloading) of .bash_history with in-memory history:
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# }}}

# Aliases {{{

alias yta='youtube-dl -f bestaudio'
alias ytv='youtube-dl -f "bestvideo[height<=720][ext=webm]+bestaudio[ext=webm]/best" --write-sub --write-auto-sub --sub-lang=en'
ytp() {
    __FMT=`youtube-dl -F $1 | fzf`
    __FMT=`echo "$__FMT" | cut -d' ' -f1`
    mpv --ytdl-format="$__FMT" "$1"
}

alias ll="ls -lcthr"
alias ls="ls -cthr"
alias l="ls -cthr"
alias ..="cd .."

alias mv="mv -i"
alias cp="cp -i"

fzf__git_hash="echo {} | grep -o '[a-f0-9]\{7\}\$' | head -1"
fzf__git_show="$fzf__git_hash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy | less -RFX --tabs=1'"
fzf__git_diff="$fzf__git_hash | xargs -I % sh -c 'git difftool %^!'"

gl() {
    git log --abbrev-commit --date=relative --color=always --pretty=format:'%C(auto)%s %C(auto)%d %C(auto)%h%Creset' --no-merges "$@" |
        fzf --cycle --no-sort --reverse --tiebreak=index --no-multi --ansi \
            --preview="$fzf__git_show" --preview-window=wrap:70%           \
            --bind "enter:execute:$fzf__git_diff"                          \
            --bind "ctrl-y:execute:$fzf__git_hash | pbcopy"                \
            --bind "ctrl-j:preview-down"                                   \
            --bind "ctrl-k:preview-up"
}

alias gs="git status --short"
alias ga="git add -ip"
alias gd="git diff --cached"
alias gc="git commit -m"

# }}}


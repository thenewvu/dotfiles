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
export PATH="$GOPATH/bin:$PATH"

export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:$PATH"
export PATH="$GEM_HOME/ruby/2.3.0/bin:$PATH"

export GREP_OPTIONS='--ignore-case --color=auto'
export CLICOLOR=1

export FZF_COMPLETION_TRIGGER='``'
export FZF_DEFAULT_OPTS="--reverse --color fg:7,hl:2,fg+:7,bg+:-1,hl+:2,info:15,prompt:2,spinner:15,pointer:2,marker:7,border:8"
export FZF_DEFAULT_COMMAND="rg --files --glob '!**/node_modules/*'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

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

# homebrew llvm need below
export PATH="/usr/local/opt/llvm/bin:$PATH"
export CC=clang
export CXX=clang++
export LD=ld.lld
export AR=llvm-ar
export RANLIB=llvm-ranlib
export CFLAGS="$CCFLAGS -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk"
export CCFLAGS="$CCFLAGS -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk"
export CXXFLAGS="$CXXFLAGS -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk"
export OBJCFLAGS="$OBJCFLAGS -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk"
export LDFLAGS="$LDFLAGS -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"

# homebrew gnu-sed need below
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# homebrew node@10 need below
export PATH="/usr/local/opt/node@10/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/node@10/lib $LDFLAGS"
export CPPFLAGS="-I/usr/local/opt/node@10/include $CPPFLAGS"

export FFF_OPENER=~/.bin/opener
export FFF_TRASH=~/.Trash

# }}}

# Command history {{{
# https://sanctum.geek.nz/arabesque/better-bash-history/

# Increase the size of history maintained by BASH
export HISTFILESIZE=1000
export HISTSIZE=${HISTFILESIZE}
# ignore recording duplicated or space-leading commands
export HISTCONTROL=ignoreboth:ignoredups:erasedups
# ignore recording some trivial commands
export HISTIGNORE='cd:ls:ll:l:bg:fg:history:nvim:gs:gd:gu:gca:gcd:gcr:gcm:gl:mpv'
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
fzf__git_show="$fzf__git_hash | xargs -I % sh -c 'git show --color=always --ignore-all-space --ignore-blank-lines --diff-filter=ad % | diff-so-fancy | less -RFX --tabs=4'"
fzf__git_diff="$fzf__git_hash | xargs -I % sh -c 'git difftool %^!'"
fzf__git_checkout="$fzf__git_hash | xargs -I % sh -c 'git checkout %'"

gl() {
    git log --abbrev-commit --date=relative --color=always                 \
            --pretty=format:'%C(auto)%s %C(auto)%d %C(auto)%h%Creset'      \
            --no-merges -n 100 "$@" |
        fzf --no-sort --reverse --tiebreak=index --no-multi --ansi         \
            --preview="$fzf__git_show" --preview-window=wrap:50%           \
            --bind "enter:execute:$fzf__git_diff"                          \
            --bind "ctrl-y:execute:$fzf__git_hash | pbcopy"                \
            --bind "ctrl-g:execute:$fzf__git_checkout"                     \
            --bind "ctrl-j:preview-down"                                   \
            --bind "ctrl-k:preview-up"
}

alias gs="git status --short"
alias gr="git ls-files --modified --exclude-standard | fzf -m --print0 | xargs -0 -o -t git checkout -p"
alias gd="git diff -b"

alias gca="git add --intent-to-add . && git ls-files --modified --others --exclude-standard | fzf -m --print0 | xargs -0 -o -t git add -p"
alias gcr="git --no-pager diff --name-only --relative --staged | fzf -m --print0 | xargs -0 -o -t git reset HEAD"
alias gcd="git diff --cached -b"
alias gcm="git commit -m"

alias gp="git push"

alias ctags="`brew --prefix`/bin/ctags"

# }}}


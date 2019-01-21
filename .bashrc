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

function prompt_right() {
  echo -e "\033[0;00m\\\t\033[0m"
}

function prompt_left() {
  echo -e "\033[0;00m\u@\h:\w\033[0m"
}

function prompt() {
  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ┄
  printf "\e]2;%s\a" "${PWD##*/}"
  compensate=5
  PS1=$(printf "%*s\r%s\n\$ " "$(($(tput cols)+${compensate}))" "$(prompt_right)" "$(prompt_left)")
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
export FZF_DEFAULT_OPTS="--height=40% --color=bw --reverse"
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

# }}}

# Command history {{{

# Increase the size of history maintained by BASH
export HISTFILESIZE=1000
export HISTSIZE=${HISTFILESIZE}
# Use leading space to hide commands from history:
export HISTCONTROL=ignorespace:ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# Ensure syncing (flushing and reloading) of .bash_history with in-memory history:
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# }}}

# Aliases {{{

alias gs="git s"
alias ga="git a"
alias gai="git ai"
alias gl="git l"
alias gc="git c"
alias gd="git d"
alias gdc="git dc"
alias gdw="git dw"
alias gdcw="git dcw"
alias gp="git p"

alias yta='youtube-dl -f bestaudio'
alias ytv='youtube-dl -f "bestvideo[height<=720][ext=webm]+bestaudio[ext=webm]/best" --write-sub --write-auto-sub --sub-lang=en'
alias mpa='mpv --no-video --ytdl-format="bestaudio,91"'
alias mpv='mpv --ytdl-format="mp4[height<=720]"'

alias ll="ls -lcthr"
alias ls="ls -cthr"
alias l="ls -cthr"
alias ..="cd .."

# }}}


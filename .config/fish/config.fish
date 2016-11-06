################################################################################
# Startup settings
################################################################################

# startx at login in only tty1
if status --is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" -eq "1"
    exec startx -- -keeptty
  end
end

################################################################################
# Environment settings
################################################################################

# no fish greeting
set -gx fish_greeting ""

# extend bin paths
set -gx PATH /home/vu/.node_modules/bin /home/vu/.bin $PATH

# fix locale issue in the recent fish version
if not set -q LANG >/dev/null
  set -gx LANG en_US.UTF-8
end

# default editor for yaourt
set -gx VISUAL "vim"

# fzf settings
set -gx FZF_DEFAULT_OPTS '--color=bw'
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob="!.git/*"'
set -gx FZF_CTRL_T_COMMAND 'rg --files --hidden --glob="!.git/*"'

# global jvm options
set -gx JAVA_TOOL_OPTIONS '-Xmx128m -Dawt.useSystemAAFontSettings=lcd -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
set -gx _JAVA_OPTIONSx '-Xmx128m -Dawt.useSystemAAFontSettings=lcd -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# package management aliases
alias paclist="expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n 50"
alias pacsize='expac -H M "%011m\t%-20n\t%10d" (comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | sort -n'

# git aliases
alias gs="git st"
alias ga="git add"
alias gl="git ls"
alias gc="git ci"
alias gd="git diff"
alias gdc="git diff --cached"
alias gco="git checkout"

# yaourt aliases
alias yt="yaourt"
alias yts="yaourt -Ss"
alias yta="yaourt -S"
alias ytr="yaourt -R"
alias ytu="yaourt -Syu --aur --noconfirm"
alias ytc="sudo pacman-remove-orphans ; paccache -ruk0 ; paccache -rk 1"

# docker aliases
alias docker-remove-exited-containers="docker rm (docker ps -q -f status=exited)"
alias docker-remove-dangling-images="docker rmi (docker images -q -f dangling=true)"

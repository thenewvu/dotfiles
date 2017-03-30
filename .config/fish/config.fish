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
set -gx VISUAL "nvim"

# fzf settings
set -gx FZF_DEFAULT_OPTS '--color=bw'
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob="!.git/*"'
set -gx FZF_CTRL_T_COMMAND 'rg --files --hidden --glob="!.git/*"'

# global jvm options
set -gx JAVA_TOOL_OPTIONS '-Xmx128m -Dawt.useSystemAAFontSettings=lcd -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
set -gx _JAVA_OPTIONSx '-Xmx128m -Dawt.useSystemAAFontSettings=lcd -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# package management aliases
alias paclist="expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort"
alias pacsize='expac -H M "%011m\t%-20n\t%10d" (comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | sort -n'

# git aliases
alias gs="git st"
alias ga="git add"
alias gl="git ls"
alias gc="git ci"
alias gd="git diff"
alias gp="git push"
alias gdc="git diff --cached"
alias gco="git checkout"

# nvim as vim
alias vim="nvim"

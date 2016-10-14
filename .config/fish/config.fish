# fix locale issue in the recent fish version
if not set -q LANG >/dev/null
  set -gx LANG en_US.UTF-8
end

# additional bin paths
set -gx PATH /home/vu/.node_modules/bin /home/vu/.bin $PATH

# default editor
set -gx VISUAL "vim"

# set custom search tool for FZF
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob="!.git/*"'
set -gx FZF_CTRL_T_COMMAND 'rg --files --hidden --glob="!.git/*"'

# disable fish greeting
set -gx fish_greeting ""

# expac aliases
alias paclist="expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n 50"
alias pacsize='expac -H M "%011m\t%-20n\t%10d" (comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | sort -n'

set -gx JAVA_TOOL_OPTIONS '-Xmx128m -Dawt.useSystemAAFontSettings=lcd -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
set -gx _JAVA_OPTIONSx '-Xmx128m -Dawt.useSystemAAFontSettings=lcd -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# start X at login
if status --is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" -eq "1"
    exec startx -- -keeptty
  end
end

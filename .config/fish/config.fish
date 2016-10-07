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

# start X at login
if status --is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" -eq "1"
    exec startx -- -keeptty
  end
end

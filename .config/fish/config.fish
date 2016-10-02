# fix locale issue in the recent fish version
if not set -q LANG >/dev/null
  set LANG en_US.UTF-8
end

# additional bin paths
set PATH /home/vu/.node-modules/bin /home/vu/.bin $PATH

# default editor
set VISUAL "vim"

# set custom search tool for FZF
set FZF_CTRL_T_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# disable fish greeting
set fish_greeting ""

# start X at login
if status --is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" -eq "1"
    exec startx -- -keeptty
  end
end

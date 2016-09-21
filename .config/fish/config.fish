# fix locale issue in the recent fish version
if not set -q LANG >/dev/null
  set -gx LANG en_US.UTF-8
end

# additional bin paths
set -gx PATH /home/vu/.node_modules/bin /home/vu/.bin $PATH

# default editor
set -gx VISUAL "vim"

# start X at login
if status --is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" -eq "1"
    exec startx -- -keeptty
  end
end

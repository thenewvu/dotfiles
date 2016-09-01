if not set -q LANG >/dev/null
  set -gx LANG en_US.UTF-8
end

set -gx PATH /home/vu/.node_modules/bin $PATH

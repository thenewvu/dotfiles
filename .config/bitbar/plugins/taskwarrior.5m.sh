#!/bin/bash

#
# <bitbar.title>TaskWarrior</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
#

task=/usr/local/bin/task

started=$($task +ACTIVE _id | head -n 1)
stopped=$($task -ACTIVE _id)

if [ "$started" != "" ]; then
    proj=$($task _get $started.project)
    if [ "$proj" != "" ]; then
        proj="$proj: "
    fi

    desc=$($task _get $started.description)
    desc=$(echo $desc | sed -e 's!http\(s\)\{0,1\}://[^[:space:]]*!!g')

    opts="terminal=false refresh=true \
        bash=/bin/bash param1=-c \
        param2='$task stop $started'"
    echo "$proj$desc ▿ | $style $opts"
else
    echo "$(echo "$stopped" | wc -l) todos ▿"
fi

echo "---"

for id in $stopped; do
    proj=$($task _get $id.project)
    if [ "$proj" != "" ]; then
        proj="$proj: "
    fi

    desc=$($task _get $id.description)
    desc=$(echo $desc | sed -e 's!http\(s\)\{0,1\}://[^[:space:]]*!!g')

    opts="terminal=false refresh=true \
        bash=/bin/bash param1=-c \
        param2='$task start $id'"

    echo "▹ $proj$desc | $opts"

    opts="alternate=true terminal=false \
        refresh=true bash=/bin/bash param1=-c \
        param2='$task done $id'"

    echo "☐ $proj$desc | $opts"
done

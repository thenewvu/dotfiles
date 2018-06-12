#!/bin/bash

#
# <bitbar.title>TaskWarrior</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
#

export PATH='/usr/local/bin:/usr/bin:$PATH'

style="color=#af51ff font='Script12 BT' size=12"

started=$(task +ACTIVE _id | head -n 1)
stopped=$(task -ACTIVE _id)

if [ "$started" != "" ]; then
    proj=$(task _get $started.project)
    if [ "$proj" != "" ]; then
        proj="$proj: "
    fi

    desc=$(task _get $started.description)

    opts="terminal=false refresh=true \
        bash=/bin/bash param1=-c \
        param2='task stop $started'"
    echo "$proj$desc | $style $opts"
else
    echo "$(echo "$stopped" | wc -l) tasks | $style"
fi

echo "---"

for id in $stopped; do
    proj=$(task _get $id.project)
    if [ "$proj" != "" ]; then
        proj="$proj: "
    fi

    desc=$(task _get $id.description)

    opts="terminal=false refresh=true \
        bash=/bin/bash param1=-c \
        param2='task start $id'"

    echo "$proj$desc | $opts $style"

    opts="alternate=true terminal=false \
        refresh=true bash=/bin/bash param1=-c \
        param2='task done $id'"

    echo "$proj$desc | $opts $style"
done

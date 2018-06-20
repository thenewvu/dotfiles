#!/bin/bash

#
# <bitbar.title>TaskWarrior</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
#

task=/usr/local/bin/task

started=$($task +ACTIVE _id | head -n 1)
stopped=$($task -ACTIVE _id)

font="font='Courier' size=12"

if [ "$started" != "" ]; then
    proj=$($task _get $started.project)
    if [ "$proj" != "" ]; then
        proj="$proj ▹ "
    fi

    desc=$($task _get $started.description)
    desc=$(echo $desc | sed -e 's!http\(s\)\{0,1\}://[^[:space:]]*!!g')

    opts="terminal=false refresh=true \
        bash=/bin/bash param1=-c \
        param2='$task stop $started'"
    echo "$proj$desc ▿ | $font color=#af5fff $opts"
else
    numof_stopped=$(echo "$stopped" | wc -l | tr -d '[:space:]')
    if [ "$numof_stopped" == "1" ]; then
        echo "1 todo ▿ | $font"
    else
        echo "$numof_stopped todos ▿ | $font"
    fi
fi

echo "---"

echo "✩ Project                          Task | $font color=gray trim=false"
echo "✔ Project                          Task | $font color=gray trim=false alternate=true"
echo '---'

for id in $stopped; do
    proj=$($task _get $id.project)

    desc=$($task _get $id.description)
    desc=$(echo $desc | sed -e 's!http\(s\)\{0,1\}://[^[:space:]]*!!g')

    opts="trim=false terminal=false refresh=true \
        bash=/bin/bash param1=-c \
        param2='$task start $id'"

    printf "✩ %-32.32s $desc | $opts $font\n" "$proj"

    opts="trim=false alternate=true terminal=false \
        refresh=true bash=/bin/bash param1=-c \
        param2='$task done $id'"

    printf "✔ %-32.32s $desc | $opts $font\n" "$proj"
done

#!/bin/bash

#
# <bitbar.title>ScreenLog</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>


pidf=/tmp/com.bitbar.screenlog.pid
logf=/tmp/com.bitbar.screenlog.log

ffmpeg_fastest="/usr/local/bin/ffmpeg -f avfoundation -framerate 1 -pixel_format bgr0 -i 1 -c:v libvpx-vp9 -cpu-used 8 -deadline realtime -crf 50 -b:v 256K"
ffmpeg_slowest="/usr/local/bin/ffmpeg -f avfoundation -framerate 1 -pixel_format bgr0 -i 1 -c:v libvpx-vp9 -cpu-used 8 -deadline realtime -crf 31 -b:v 0"

outdir=~/Documents/screenlogs

if [ -f "$pidf" ]; then
    pid=$(cat $pidf) 
    if [ "$pid" != "" ]; then
        running=true
    fi
fi

cmd=$1
if [ "$cmd" == "" ]; then
    cmd="status"
fi

if [ "$cmd" == "status" ]; then

    if [ $running ]; then 
        stat=$(ps -p $pid -o stat= | tr -d ' ')
        if [ "$stat" == "T" ]; then
            echo "◉ $(ps -p $pid -o etime=) ▿ | font='Script12 BT' color=#F2B13C"
            echo "---"
            echo "Resume | terminal=false refresh=true bash=$0 param1=resume"
        else
            echo "◉ $(ps -p $pid -o etime=) ▿ | font='Script12 BT' color=#D94D40"
            echo "---"
            echo "Pause | terminal=false refresh=true bash=$0 param1=pause"
        fi
        echo "---"
        echo "Stop | terminal=false refresh=true bash=$0 param1=stop"
    else
        echo "◉  ▿ "
        echo "---"
        echo "Start (Lo quality) | terminal=false refresh=true bash=$0 param1=start-fastest font='Script12 BT'"
        echo "---"
        echo "Start (Hi quality) | terminal=false refresh=true bash=$0 param1=start-slowest font='Script12 BT'"
    fi
fi

if [ "$cmd" == "start-fastest" ]; then
    nohup $ffmpeg_fastest $outdir/$(date +%Y-%m-%d-%H-%M.webm) &
    echo $! > $pidf
fi

if [ "$cmd" == "start-slowest" ]; then
    nohup $ffmpeg_slowest $outdir/$(date +%Y-%m-%d-%H-%M.webm) &
    echo $! > $pidf
fi

if [ "$cmd" == "stop" ]; then
    kill -SIGQUIT $pid && rm $pidf
fi

if [ "$cmd" == "pause" ]; then
    kill -SIGSTOP $pid
fi

if [ "$cmd" == "resume" ]; then
    kill -SIGCONT $pid
fi

#!/bin/bash

#
# <bitbar.title>ScreenLog</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>


pidf=/tmp/com.bitbar.screenlog.pid

ffmpeg_lo_quality="/usr/local/bin/ffmpeg -f avfoundation -r 1 -pixel_format bgr0 -i 1 -r 1 -vf mpdecimate,setpts=N/FRAME_RATE/TB -c:v libvpx-vp9 -cpu-used 8 -deadline realtime -crf 50 -b:v 0"
ffmpeg_me_quality="/usr/local/bin/ffmpeg -f avfoundation -r 1 -pixel_format bgr0 -i 1 -r 1 -vf mpdecimate,setpts=N/FRAME_RATE/TB -c:v libvpx-vp9 -cpu-used 8 -deadline realtime -crf 40 -b:v 0"
ffmpeg_hi_quality="/usr/local/bin/ffmpeg -f avfoundation -r 1 -pixel_format bgr0 -i 1 -r 1 -vf mpdecimate,setpts=N/FRAME_RATE/TB -c:v libvpx-vp9 -cpu-used 8 -deadline realtime -crf 31 -b:v 0"

outdir=~/Documents/screenlogs

font="font='Script12 BT' size=12"

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
            echo "◉ ▿ | $font color=#F2B13C"
            echo "---"
            echo "Resume | $font terminal=false refresh=true bash=$0 param1=resume"
        else
            echo "◉ ▿ | $font color=#D94D40"
            echo "---"
            echo "Pause | $font terminal=false refresh=true bash=$0 param1=pause"
        fi
        echo "---"
        echo "Stop | $font terminal=false refresh=true bash=$0 param1=stop"
    else
        echo "◉ ▿ "
        echo "---"
        echo "Start (Lo quality) | $font terminal=false refresh=true bash=$0 param1=start_lo_quality"
        echo "---"
        echo "Start (Me quality) | $font terminal=false refresh=true bash=$0 param1=start_me_quality"
        echo "---"
        echo "Start (Hi quality) | $font terminal=false refresh=true bash=$0 param1=start_hi_quality"
    fi
fi

if [ "$cmd" == "start_lo_quality" ]; then
    nohup $ffmpeg_lo_quality $outdir/$(date +%Y-%m-%d-%H-%M.webm) >/dev/null 2>&1 &
    echo $! > $pidf
fi

if [ "$cmd" == "start_me_quality" ]; then
    nohup $ffmpeg_me_quality $outdir/$(date +%Y-%m-%d-%H-%M.webm) >/dev/null 2>&1 &
    echo $! > $pidf
fi

if [ "$cmd" == "start_hi_quality" ]; then
    nohup $ffmpeg_hi_quality $outdir/$(date +%Y-%m-%d-%H-%M.webm) >/dev/null 2>&1 &
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

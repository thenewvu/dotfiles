#!/bin/bash
#Set the parameters passed to this script to meaningful variable names.
connection_type="$1"
essid="$2"
bssid="$3"

if [ "${connection_type}" == "wireless" ]; then

        #Change below to match your networks.
        case "$essid" in
         "TANG3")
                arp -s 192.168.3.33 c4:e9:84:ad:2f:10
         ;;
         "Luu Thi Thao")
                arp -s 192.168.7.1 4c:f2:bf:b6:a5:10
         ;;
         *)
                echo "Static ARP not set. No network defined."
         ;;
       esac
fi

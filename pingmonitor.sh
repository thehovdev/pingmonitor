#!/bin/bash

# App : pingmonitor
# Version : 1.0
# Author : Afgan Khalilov, hovdev@protonmail.ch
# Created in Beyli creative technologies, https://beylitech.az
# Developed for strongSwan VPN on Linux

# begin of app

# define our gateway list
declare -a gateways=(
"10.5.21.1"
"10.5.20.2"
)

# get last ip from our gateway list
last=${gateways[$(expr ${#gateways[@]} - 1)]}
logfile="/var/log/pingmonitor.log"

# loop for check gateways
    for i in "${gateways[@]}"
    do
        # ping our gateways as one
        ping -c 1 "$i"

        # check if gateway reachable
        if [ $? -eq 0 ]
            then
            echo "ping success"
            # if all our gateways reachable and if this gateway last
            if [ "$i" = "$last" ]
                then
                # do something and exit programm
                echo "all pings succesfull"
                exit 0
            fi
        else
            # if 1 gateway from our loop fails, then restart vpn server or do something
            echo "$i ping fail"
        /usr/sbin/strongswan restart
            printf "%s\t $i gateway not reachable, restarting vpn.. \n" "$(date)" >>$logfile
	    exit 0
        fi
    done

#!/bin/bash

# App : ping.monitor
# Version : 1.0
# Author : Afgan Khalilov
# Developed for strongSwan VPN on Linux

# define our gateway list
declare -a gateways=(
"192.168.88.121"
"10.5.20.1"
)

# get last ip from our gateway list
last=${gateways[$(expr ${#gateways[@]} - 1)]}

# loop for check gatewats
while true;
do
    for i in "${gateways[@]}"
    do
        # ping out gateways as one
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
            echo "ping fail"
            exit 0
        fi

    done
done

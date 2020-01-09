#! /bin/bash

NICLIST=$(cat /proc/net/dev | grep -e ":" | grep -v -e "lo"| cut -d ":" -f1)

for i in $(echo $NICLIST) ;
        do NICSTATUS=$(sudo ethtool $i 2>/dev/null | grep "Link detected" | cut -d : -f2) ;
        if [ $NICSTATUS == "yes" ]
        then
          NICSTATUS="Status: active"
        else
          NICSTATUS="Status: not active"
        fi;
        NICSPEED=$(ethtool $i | grep -i speed);
        NICIP=$(ip addr show $i | grep "inet\b" | awk '{print $2}' | cut -d/ -f1);
        echo $i":" $NICIP , $NICSTATUS , $NICSPEED
        done

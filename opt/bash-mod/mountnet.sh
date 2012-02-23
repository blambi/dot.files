#!/bin/bash

if [ $( ps aux | awk -vPPID=$PPID '$2 == PPID { print $11 }' ) == "/bin/login" ]; then
    
    # check and try to mount if stuff isn't mounted
    mount | grep /mnt/net/catacombs > /dev/null
    if [ $? == 1 ]; then
        echo "mounting catacombs"
        mount /catacombs
    fi

    mount | grep /mnt/net/attic > /dev/null
    if [ $? == 1 ]; then
        echo "mounting attic"
        mount /mnt/net/attic
    fi 

    mount | grep /mnt/net/warren > /dev/null
    if [ $? == 1 ]; then
        echo "mounting warren"
        mount /mnt/net/warren
    fi
fi

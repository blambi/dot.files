#!/bin/bash

if [ $( ps aux | awk -vPPID=$PPID '$2 == PPID { print $11 }' ) == "/bin/login" ]; then
    echo
    fortune debian-hints
fi

#!/bin/bash

function bashmod-toggle()
{
    mod="$HOME/opt/bash-mod/$1.sh"

    if [ ! -f $mod ]; then
        echo "ehm no such mod!"
        return
    fi

    if [ -x $mod ]; then
        echo "Disabling $1"
        chmod -x $mod
    else
        echo "Enabling $1"
        chmod +x $mod
    fi
}
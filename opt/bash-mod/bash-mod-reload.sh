#!/bin/bash

function bashmod-reload()
{
    echo "Reloading..."
    for mod in $HOME/opt/bash-mod/*.sh; do
        if [ -x "$mod" ]; then
            echo $( basename $mod )
            source $mod
        fi
    done

}

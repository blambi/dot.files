#!/bin/bash

function bashmod-ls()
{
    echo "Enabled bash-mods:"
    
    for mod in $HOME/opt/bash-mod/*.sh; do
        if [ -x "$mod" ]; then
            echo $( basename $mod )
        fi
    done

    echo
    echo "Disabled:"

    for mod in $HOME/opt/bash-mod/*.sh; do
        if [ ! -x "$mod" ]; then
            echo $( basename $mod )
        fi
    done
}

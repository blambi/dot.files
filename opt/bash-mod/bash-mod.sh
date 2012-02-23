#!/bin/bash

# Version 2 of the CLI
# now includes all of them inside a function.

function bash-mod()
{
    case $1 in
        toggle)
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
            ;;          
        reload)
            echo "Reloading..."
            for mod in $HOME/opt/bash-mod/*.sh; do
                if [ -x "$mod" ]; then
                    echo $( basename $mod )
                    source $mod
                fi
            done
            ;;
        ls) # LS!
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
            ;;
        *)
            echo "Sorry only accepts: ls, reload, toggle [mod-name]"
            ;;
    esac
}

#!/bin/bash

proxy-use()
{
    local HELP=0
    local PROXYS="$( $HOME/opt/settings/proxies.sh )"

    if [ ! $1 ]; then
        HELP=1
    elif [ "$1" == "--help" ]; then
        HELP=1
    elif [ "$1" == "-h" ]; then
        HELP=1
    fi

    if [ $HELP == 1 ]; then
        echo "proxy-use.sh"
        echo "(C) Patrik Nilsson 2007"
        echo -e "controls the \$http_proxy and \$HTTP_PROXY"
        echo
        echo "usage:"
        echo -e "proxy-use.sh none\t\tdisables use of any proxy"
        echo -e "proxy-use.sh -n HOSTNAME PORT\tuse proxy at HOSTNAME PORT"
        echo
        echo -e "predefined proxies:"
        $HOME/opt/settings/proxies.sh show
        echo
    else
    
        if [ "$1" == "none" ]; then # disable
            unset http_proxy
            unset HTTP_PROXY
            echo "disabled proxy use"
        elif [ "$1" == "-n" ]; then # set after a directly specified
            if [ $# == 3 ]; then
                echo "setting 'http://$2:$3' as proxy"
                http_proxy="http://$2:$3"
                HTTP_PROXY="$http_proxy"
                export http_proxy
                export HTTP_PROXY
            else
                echo "Error: you forgot some arguments"
            fi
        elif [ $# == 1 ]; then # set after a predefined
            local PROXY_NAME=$1
            local FIXED=0
            for X in $PROXYS; do
                if [ "$( echo $X | grep $PROXY_NAME | wc -l )" == "1" ]; then
                    local PROXY=$( echo $X | sed -e 's/^.*|//' -e 's/\\n//' )
                    echo "setting 'http://$PROXY' as proxy"
                    http_proxy="http://$PROXY"
                    HTTP_PROXY="$http_proxy"
                    export http_proxy
                    export HTTP_PROXY
                    FIXED=1
                fi
            done
            
            if [ $FIXED == 0 ]; then
                echo "No proxy defined under the name $PROXY_NAME."
            fi
        else
            echo "err why are we here then?"
        fi
    fi
}

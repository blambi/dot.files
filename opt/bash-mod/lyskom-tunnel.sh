#!/bin/bash

function lyskom-tunnel()
{
    if [ $(  ps auxw | grep kom.lysator.liu.se:4894 | grep -v grep | wc -l ) -ge 1 ]; then
        echo "Sorry lyskom tunnel seems up"
    else
        ssh -f -N -L 4894:kom.lysator.liu.se:4894 lysator
    fi
}

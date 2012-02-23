#!/bin/bash

function encfs-remount()
{
    mount | grep /home/patrik/dokument/krypterat > /dev/null
    if [ $? == 0 ]; then
        echo "unmounting encfs"
        fusermount -u /home/patrik/dokument/krypterat
    fi

    mount | grep /home/patrik/dokument/krypterat > /dev/null
    if [ $? == 1 ]; then
        echo "mounting encfs"
        encfs /mnt/enc-usb /home/patrik/dokument/krypterat
    fi
}

function HOOK_ENCMOUNT()
{
    echo "mounting encfs"
    mount | grep /home/patrik/dokument/krypterat > /dev/null
    if [ $? == 1 ]; then
        encfs /mnt/enc-usb /home/patrik/dokument/krypterat
    fi
}

if [ $( ps aux | awk -vPPID=$PPID '$2 == PPID { print $11 }' ) == "/bin/login" ]; then
    # check and try to mount if stuff isn't mounted
    mount | grep /home/patrik/dokument/enc-usb > /dev/null
    if [ $? == 1 ]; then
        echo "mounting raw enc-usb"
        mount /mnt/enc-usb
        encfs-remount
    fi
fi

function infected() {
    pushd /home/patrik/programmering/dot.files/ > /dev/null
    if [ "$( git st | wc -l)" -gt 2 ]; then
        echo "********* WARNING ********"
        echo "infection is quite posible"
        echo "**************************"
        git st
    fi
    popd > /dev/null

    if [ -e ~/.bash_aliases ]; then
        echo "WARNING: We have a bash alias file.."
    fi
}

infected

function infected() {
    pushd ~/progammering/dot.files/ > /dev/null
    if [ "$( git st | wc -l)" -gt 2 ]; then
        echo "********* WARNING ********"
        echo "infection is quite posible"
        echo "**************************"
        git st
    fi
    popd > /dev/null
}

infected

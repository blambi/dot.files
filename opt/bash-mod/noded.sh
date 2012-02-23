function noded()
{
    if [ ! -d $HOME/nodeone-dev/platforms/$1 ]; then
        echo "Sorry not found was it any of these?"
        ls $HOME/nodeone-dev/platforms/
        return
    fi

    pushd $HOME/nodeone-dev/platforms/$1
    echo "Just popd to jump back"
}

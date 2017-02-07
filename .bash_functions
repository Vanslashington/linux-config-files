# cl (cd + ls) command
cl() {
    if [ "$1" != "" ]; then
        cd "$1"
    fi
    ls
}

# md (mkdir + cd) command
md() {
    if [ "$1" != "" ]; then
        mkdir "$1"
    fi
    cd "$1"
}

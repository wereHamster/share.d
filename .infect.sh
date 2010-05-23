#!/bin/sh

flag="$@"

function relink() {
  test -h $1 || ln -s -v $flag $2 $1
}

SHARED=$(pwd)
for x in *; do
    case $x in
        README.md) ;;
        *) relink ~/.$x ${SHARED}/$x ;;
    esac
done

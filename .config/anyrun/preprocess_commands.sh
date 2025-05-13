#!/usr/bin/bash

SHOULD_TERMINAL=$1

shift

case $SHOULD_TERMINAL in

    "no-term")
        printf "uwsm app -- ${@}"
    ;;

    "term")
        printf "${@}"
    ;;

esac

#!/bin/bash

. "$HELLO_IT_SCRIPT_SH_LIBRARY/com.github.ygini.hello-it.scriptlib.sh"

function onClickAction {
    sudo /usr/local/bin/com.github.ygini.enrollme.sh -c
}

function setTitleAction {
    updateState ${STATE[2]}
}

main "$@"

exit 0

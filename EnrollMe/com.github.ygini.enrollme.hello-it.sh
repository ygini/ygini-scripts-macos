#!/bin/bash

. "$HELLO_IT_SCRIPT_SH_LIBRARY/com.github.ygini.hello-it.scriptlib.sh"

function onClickAction {
    sudo /usr/local/bin/com.github.ygini.enrollme.sh
}

main "$@"

exit 0

#!/bin/bash

. "$HELLO_IT_SCRIPT_FOLDER/com.github.ygini.hello-it.scriptlib.sh"
SCRIPT_FOLDER="$(dirname ${BASH_SOURCE[0]})"

function onClickAction {
    "${SCRIPT_FOLDER}/com.github.ygini.temporaryadmin/com.github.ygini.temporaryadmin"
}

main "$@"

exit 0

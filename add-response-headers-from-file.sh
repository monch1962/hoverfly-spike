#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [ "$#" -ne 1 ]; then
    echo "Expecting to be invoked with 'add-response-headers-from-file.sh FILE_CONTAINING_HEADERS'"
    echo "e.g. 'add-response-headers-from-file.sh sample-headers.json'"
    exit 1
fi

echo $(cat) | 
    jq --slurpfile BODY_FROM_FILE $1 '.data.pairs[0].response.headers = $BODY_FROM_FILE[0]'
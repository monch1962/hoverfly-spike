#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [ "$#" -ne 1 ]; then
    echo "Expecting to be invoked with 'add-response-body-from-file.sh FILE_CONTAINING_HEADERS'"
    echo "e.g. 'add-response-body-from-file.sh sample-body.json' or 'add-response-body-from-file.sh sample-body.xml'"
    exit 1
fi

BODY_FILE=$1
FILE_CONTENT=$(< $BODY_FILE)

if jq -e . > /dev/null 2>&1 <<< $FILE_CONTENT; then
    echo $(cat) | 
        jq --slurpfile BODY_FROM_FILE $BODY_FILE '.data.pairs[0].response.body = ($BODY_FROM_FILE[0]|tostring)'
else
    # Assume the body file is XML
    echo $(cat) |
        jq --arg xml "$(<"$BODY_FILE")" '.data.pairs[0].response.body = ($xml | @html)' 
fi
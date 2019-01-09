#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [ "$#" -ne 3 ]; then
    echo "Expecting to be invoked with 'new-stub.sh HTTP_VERB URL HTTP_RESPONSE_CODE'"
    echo "e.g. 'new-stub.sh GET https://localhost:8000/posts/1 200' or 'new-stub.sh POST https://jsonplaceholder.typicode.com/users 202'"
    exit 1
fi

VERB=$(echo $1|tr '[:lower:]' '[:upper:]')
URL=$2
SCHEME=$(echo $URL|sed -e 's/:.*//g')
DESTINATION=$(echo $URL| sed -e 's/https:\/\///g' | sed -e 's/\/.*//g')
HTTP_CODE=$3
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S%z)
#if [[ "$OSTYPE" == "darwin"* ]]; then
#    USER=$(logname)
#elif [[ "$OSTYPE" == "win"* ]]; then
#    USER=%USERNAME%
#fi

echo "{}" |
    jq '.data.pairs[0].request.matcher = "exact"' |
    jq '.data.globalActions.delays = []' |
    jq '.meta.schemaVersion = "v5"' |
    jq '.meta.hoverflyVersion = "v0.17.7"' |
    jq --arg TIMESTAMP $TIMESTAMP '.meta.timeExported = ($TIMESTAMP)' |
    jq '.data.pairs[0].request.method[0].matcher = "exact"' |
    jq --arg VERB $VERB '.data.pairs[0].request.method[0].value = ($VERB)' |
    jq '.data.globalActions.delays = []' |
    jq '.data.pairs[0].request.path[0].matcher = "exact"' |
    jq '.data.pairs[0].request.path[0].value = "/"' |
    jq '.data.pairs[0].request.scheme[0].matcher = "exact"' |
    jq --arg SCHEME $SCHEME '.data.pairs[0].request.scheme[0].value = ($SCHEME)' |
    jq '.data.pairs[0].request.destination[0].matcher = "exact"' |
    jq --arg DESTINATION $DESTINATION '.data.pairs[0].request.destination[0].value = ($DESTINATION)' |
    jq --arg HTTP_CODE $HTTP_CODE '.data.pairs[0].response.status = ($HTTP_CODE|tonumber)' |
    jq '.data.pairs[0].response.body = {}' |
    jq '.data.pairs[0].response.headers = {}' |
    jq '.data.pairs[0].response.templated = false'

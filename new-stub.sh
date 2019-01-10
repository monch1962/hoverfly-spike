#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [ "$#" -ne 3 ]; then
    echo "Expecting to be invoked with 'new-stub.sh HTTP_VERB URL HTTP_RESPONSE_CODE'"
    echo "e.g. 'new-stub.sh GET https://localhost:8000/posts/1 200' or 'new-stub.sh POST https://jsonplaceholder.typicode.com/users 202'"
    exit 1
fi

VERB=$(echo $1|tr '[:lower:]' '[:upper:]')
URL=$2
HTTP_CODE=$3
SCHEME=$(echo $URL|sed -e 's/:.*//g')
#DESTINATION=$(echo $URL| sed -e 's/http.*:\/\///g' | sed -e 's/\/.*//g')
DESTINATION=$(echo $URL | sed -e 's/http.\{0,1\}:\/\///g' | sed -e 's/\/.*//g')
PATH1=$(echo $URL | sed -e 's/http.\{0,1\}:\/\///g' | sed -e 's![^/]*/!/!')
#echo $PATH1
#echo $DESTINATION
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S%z)

echo "{}" |
#    jq '.data.pairs[0].request.matcher = "exact"' |
    jq --arg TIMESTAMP $TIMESTAMP '.meta.timeExported = ($TIMESTAMP)' |
    jq '.data.pairs[0].request.path[0].matcher = "exact"' |
    jq --arg PATH1 $PATH1 '.data.pairs[0].request.path[0].value = ($PATH1)' |
    jq '.data.pairs[0].request.method[0].matcher = "exact"' |
    jq --arg VERB $VERB '.data.pairs[0].request.method[0].value = ($VERB)' |
    jq '.data.globalActions.delays = []' |
    jq '.data.pairs[0].request.destination[0].matcher = "exact"' |
    jq --arg DESTINATION $DESTINATION '.data.pairs[0].request.destination[0].value = ($DESTINATION)' |
    jq '.data.pairs[0].request.scheme[0].matcher = "exact"' |
    jq --arg SCHEME $SCHEME '.data.pairs[0].request.scheme[0].value = ($SCHEME)' |
    jq --arg HTTP_CODE $HTTP_CODE '.data.pairs[0].response.status = ($HTTP_CODE|tonumber)' |
    jq '.data.pairs[0].request.body[0].matcher = "exact"' |
    jq '.data.pairs[0].request.body[0].value = ""' |
    jq '.data.pairs[0].request.query = {}' |
    jq '.data.pairs[0].response.body = "{}"' |
    jq '.data.pairs[0].response.encodedBody = false' |
    jq '.data.pairs[0].response.headers = {}' |
    jq '.data.pairs[0].response.templated = false' |
    jq '.meta.schemaVersion = "v5"' |
    jq '.meta.hoverflyVersion = "v0.17.7"' |
    jq '.data.globalActions.delays = []'



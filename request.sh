#!/bin/bash

function hash_hmac {
    digest="$1"
    data="$2"
    key="$3"
    shift 3
    echo -en "$data" | openssl dgst "-$digest" -hmac "$key" -binary | base64
}

DATA=`echo Thu, $(date +%d) Jan 2020 $(date +%H -d '+ 3 hours'):$(date +%M):$(date +%S) GMT`
#DATA=`date --rfc-email`
USERNAME="v9.3.0"
PASSWORD="a1b2c3d4"
REQUEST_PATH="/location"
REQUEST_METHOD="POST"
ALGORITHM=sha1 #sha1,sha256,sha384,sha512 (sha512 seems to not work)
SIG=`hash_hmac ${ALGORITHM} "date: ${DATA}\n${REQUEST_METHOD} ${REQUEST_PATH} HTTP/1.1" ${PASSWORD}`

echo curl -i -X ${REQUEST_METHOD} http://localhost:8000${REQUEST_PATH}  -H \"date: $DATA\" -H \"authorization:hmac username=\\\"${USERNAME}\\\", algorithm=\\\"hmac-${ALGORITHM}\\\", headers=\\\"date request-line\\\", signature=\\\"${SIG}\\\"\" \#the quotes from authorization is mandatory

curl -i -X ${REQUEST_METHOD} http://localhost:8000${REQUEST_PATH}  -H "date: $DATA" -H "authorization:hmac username=\"${USERNAME}\", algorithm=\"hmac-${ALGORITHM}\", headers=\"date request-line\", signature=\"${SIG}\""

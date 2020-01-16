#!/bin/bash

docker run -d \
  --rm --name=kong-hmac \
  -e IFOOD_APP_9_3_0=a1b2c3d4 \
  -p 8000:8000 \
  -p 8001:8001 \
  -e DECLARATIVES_DIR="/yamls" \
  -v ${PWD}/yamls:/yamls \
  leandrocarneiro/kong:1.1.2-centos-i

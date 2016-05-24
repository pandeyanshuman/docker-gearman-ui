#!/bin/bash

if [ "x${SERVER_ADDR}" == "x" ]; then 
  echo "Please specify the SERVER_ADDR"
  exit 1
fi

sed -i s/"name: \"\""/"name: \"${SERVER_ADDR}\""/  /gearmanui/config.yml
sed -i s/"addr: \"\""/"addr: \"${SERVER_ADDR}:4730\""/  /gearmanui/config.yml

apache2ctl -D FOREGROUND

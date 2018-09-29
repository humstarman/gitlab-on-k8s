#!/bin/bash

if [ ! -x "$(command -v kubectl)" ]; then
  echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - [ERROR] - no kubectl installed!"
  exit 1
fi
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - [INFO] - kubectl found"
exit 0

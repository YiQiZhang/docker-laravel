#!/bin/sh

DIR_NAME=$1
REPOSITORY_ADDR=$2

if [ ! -d "${DIR_NAME}" ]; then
  git clone ${REPOSITORY_ADDR} ${DIR_NAME}
else
  cd ${DIR_NAME}
  git pull
fi

exit 0

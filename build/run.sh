#!/bin/bash

. /hackage/setup.sh

server=$(cat /hackage/server)

echo -e "${ADMIN_USER}\n${ADMIN_PASS}" | hackage-build init -v $server http://hackage.haskell.org --cache-dir=/hackage/${BUILD_CACHE}

hackage-build build $1 -vv --run-time=${BUILD_RUN_TIME} --interval=${BUILD_INTERVAL} --continuous --cache-dir=/hackage/${BUILD_CACHE}

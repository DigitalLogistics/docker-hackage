#!/bin/bash

. /setup.sh

cp setup.sh /hackage/
hackage-server init -v3 --state-dir=/hackage --admin="${ADMIN_USER}:${ADMIN_PASS}"
hackage-server run -v3  --state-dir=/hackage --tmp-dir=/hackage/tmp

#!/bin/bash

. /setup.sh

hackage-server init -v3 --state-dir=/hackage --admin="${ADMIN_USER}:${ADMIN_PASS}"

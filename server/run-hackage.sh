#!/bin/sh

. ./setup.sh

DATADIR=$1
set -e

# Delete stale lock files and build cache
find $DATADIR -name "open.lock" -exec sudo rm {} \;
sudo rm -rf $DATADIR/build-cache

server_id=$(docker run -d -p $PORT:8080 -v $DATADIR:/hackage boothead/hackage-server)

echo "Hackage running in ${server_id}"

server_ip=$(docker inspect $server_id | grep IPAddress | cut -d'"' -f4)
server_local_port=$(docker port $server_id 8080)

echo "Hackage running in ${server_id} ${server_ip}:8080"

cp ./setup.sh $DATADIR/

echo "http://${server_ip}:8080" > $DATADIR/server
echo "http://hackage.haskell.org/" > $DATADIR/mirror.cfg
echo "http://${ADMIN_USER}:${ADMIN_PASS}@${server_ip}:8080" >> $DATADIR/mirror.cfg

sleep 10 # TODO: poll until web server comes up

echo "run \"docker run -t -d --volumes-from $server_id boothead/hackage-build\" for a package builder"

echo "run \"docker run -t -d --volumes-from $server_id boothead/hackage-mirror\" for mirroring from hackage.haskell.org"

# docker run -t -d --volumes-from $server_id boothead/hackage-mirror

echo "You can access your local hackage at http://127.0.0.1:${server_local_port}"


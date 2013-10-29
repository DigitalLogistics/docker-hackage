#!/bin/sh

. ./setup.sh

DATADIR=$1
set -e

# Delete stale lock files
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

sleep 5 # TODO: poll until web server comes up

docker run -t -d --volumes-from $server_id boothead/hackage-build

# docker run boothead/hackage-base sh -c "echo -e \"${ADMIN_USER}\n${ADMIN_PASS}\n\" | hackage-build init http://${server_ip}:8080 http://hackage.hackell.org; hackage-build build -vv --run-time=${BUILD_RUN_TIME} --interval=${BUILD_INTERVAL} --continuous"

echo "You can access your local hackage at http://localhost:${PORT}"


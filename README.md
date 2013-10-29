Hackage on Docker
================

Usage
-----

Run the script in `server` with a path to the local directory that you
want to host hackage with. This will be added as a volume

./server/run-hackage /path/to/local/hackage

Bugs
----

Currently this doesn't work as expected with either docker version
0.6.4 or docker built from master.

Launching the boothead/hackage-server container succeeds, but trying
to lauch the boothead/hackage-build container with --volumes-from the
server fails

TODO: Link to bug report

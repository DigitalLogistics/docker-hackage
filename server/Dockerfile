FROM boothead/hackage-base

MAINTAINER Ben Ford <ben@dlstartup.com>

ADD setup.sh /setup.sh
ADD init.sh /init.sh
ADD run.sh /run.sh

# RUN chmod +x /*.sh

# EXPOSE 8080

VOLUME ["/hackage"]

# /hackage-server-master/dist/build/hackage-server/hackage-server init --static-dir=datafiles --state-dir=/hackage --admin=\"${ADMIN_USER}:${ADMIN_PASS}\" ;


RUN "/init.sh"

ENTRYPOINT ["/run.sh"]

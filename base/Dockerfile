FROM boothead/haskell-platform

MAINTAINER Ben Ford <ben@dlstartup.com>

# dependencies
RUN apt-get -f -y --force-yes install unzip curl libicu48 libicu-dev netbase
RUN cabal update

RUN curl -LO https://github.com/haskell/hackage-server/archive/master.zip

RUN unzip master.zip
WORKDIR /hackage-server-master
RUN cabal install --global


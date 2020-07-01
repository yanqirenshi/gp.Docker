##### ################################################################
#####
#####    Base
#####    ====
#####      ???
#####
#####    Build
#####    -----
#####      docker build -t renshi/genisu.party.cl -f Dockerfile.cl .
#####
#####    Run
#####    ---
#####      docker run  -it -p renshi/genisu.party.cl
#####      docker run  -d  -p renshi/genisu.party.cl
#####      docker exec -it renshi/genisu.party.cl /bin/bash
#####
##### ################################################################
FROM ubuntu:18.04

MAINTAINER Renshi <yanqirenshi@gmail.com>


##### ################################################################
#####  Install libs
##### ################################################################
USER root

RUN apt -y update
RUN apt -y upgrade

RUN apt -y install sudo curl wget git libev-dev


##### ################################################################
#####   roswell
##### ################################################################
USER root
WORKDIR /tmp

RUN apt -y install git build-essential automake libcurl4-openssl-dev

RUN curl -L https://github.com/roswell/roswell/releases/download/v19.08.10.101/roswell_19.08.10.101-1_amd64.deb --output roswell.deb

RUN dpkg -i roswell.deb


##### ################################################################
#####   Group / User
##### ################################################################
USER root

RUN groupadd appl-users
RUN useradd -d /home/appl-user -m -g appl-users appl-user


##### ################################################################
#####   roswell
##### ################################################################
USER appl-user
WORKDIR /home/appl-user

RUN ros setup

RUN ros install woo

RUN mkdir -p /home/appl-user/prj
RUN mkdir /home/appl-user/prj/libs
RUN mkdir /home/appl-user/.asdf


##### ################################################################
#####  Copy Source Code
##### ################################################################
USER appl-user
WORKDIR /home/appl-user/prj/libs/

###
### clone projects
###
RUN git clone https://github.com/yanqirenshi/world2world.git
RUN git clone https://github.com/yanqirenshi/sephirothic.git
RUN git clone https://github.com/yanqirenshi/takajin84key.git

RUN git clone https://github.com/yanqirenshi/s-serialization
RUN git clone https://github.com/yanqirenshi/upanishad.git
RUN git clone https://github.com/yanqirenshi/shinrabanshou.git

RUN git clone https://github.com/yanqirenshi/lack-middleware-validation.git

RUN git clone https://github.com/yanqirenshi/api.Neo4j.git

###
### make symbolic links for *.asd
###
RUN ln -s /home/appl-user/prj/libs/world2world/world2world.asd         /home/appl-user/.asdf/world2world.asd
RUN ln -s /home/appl-user/prj/libs/sephirothic/sephirothic.asd         /home/appl-user/.asdf/sephirothic.asd
RUN ln -s /home/appl-user/prj/libs/takajin84key/takajin84key.asd       /home/appl-user/.asdf/takajin84key.asd

RUN ln -s /home/appl-user/prj/libs/upanishad/upanishad.asd             /home/appl-user/.asdf/upanishad.asd
RUN ln -s /home/appl-user/prj/libs/s-serialization/s-serialization.asd /home/appl-user/.asdf/s-serialization.asd
RUN ln -s /home/appl-user/prj/libs/shinrabanshou/shinrabanshou.asd     /home/appl-user/.asdf/shinrabanshou.asd

RUN ln -s /home/appl-user/prj/libs/lack-middleware-validation/lack-middleware-validation.asd /home/appl-user/.asdf/lack-middleware-validation.asd

RUN ln -s /home/appl-user/prj/libs/api.Neo4j/api.neo4j.asd /home/appl-user/.asdf/api.neo4j.asd


##### ################################################################
#####  setting project of strobolights
##### ################################################################
USER appl-user
WORKDIR /home/appl-user/prj/

RUN git clone https://github.com/yanqirenshi/Strobolights.git

RUN ln -s /home/appl-user/prj/Strobolights/strobolights.asd /home/appl-user/.asdf/strobolights.asd

CMD ["/bin/bash"]

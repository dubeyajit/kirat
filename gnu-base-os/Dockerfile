FROM ubuntu:18.04
LABEL Description="Image for building kirat"

RUN apt update
RUN apt install -y libldap2-dev rng-tools libbz2-dev zlib1g-dev libsqlite3-dev libreadline-dev pcscd scdaemon
RUN apt install -y make wget file pinentry-tty ca-certificates lbzip2 bzip2 gcc
RUN apt clean

RUN apt-get update && apt-get install -y --no-install-recommends gzip curl ca-certificates
RUN apt-get install -y python-pip

#RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
#RUN apt-get update
#RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y python3-pip 2to3 unoconv vim
RUN pip3 install --user chardet python-dateutil 

WORKDIR /usr/bin
RUN ln -si python3 python
WORKDIR /

RUN pip3 install --user --upgrade pip setuptools wheel

# Set the default command to run when starting
CMD [ "bash" ]
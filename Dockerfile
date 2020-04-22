FROM ubuntu:rolling
LABEL Description="Image for building kirat"

RUN apt update
RUN apt install -y libldap2-dev rng-tools libbz2-dev zlib1g-dev libsqlite3-dev libreadline-dev pcscd scdaemon
RUN apt install -y make wget file pinentry-tty ca-certificates lbzip2 bzip2 gcc
RUN apt clean

RUN apt-get update && apt-get install -y --no-install-recommends gzip curl ca-certificates
RUN apt-get -y install python-pip

#RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
#RUN apt-get update
#RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
#ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y python3-pip 2to3 unoconv vim
RUN pip3 install --user chardet python-dateutil 

WORKDIR /usr/bin
RUN ln -si python3 python
WORKDIR /

RUN pip3 install --user --upgrade pip setuptools wheel

RUN useradd -rm -d /home/gnuhealth -s /bin/bash -g root -G sudo -u 1000 gnuhealth

USER gnuhealth
WORKDIR /home/gnuhealth/

ENV BASEFILE="gnuhealth-3.6.3"
ENV DUMPFILE="gnuhealth-3.6.3.tar.gz"
ENV SIGFILE="gnuhealth-3.6.3.tar.gz.sig"
ENV SETUPFILE="gnuhealth-setup-latest.tar.gz"

RUN curl -o ${DUMPFILE} -SL "https://ftp.gnu.org/gnu/health/$DUMPFILE"
RUN curl -o ${SIGFILE} -SL "https://ftp.gnu.org/gnu/health/$SIGFILE"

RUN gpg --recv-key 0xC015E1AE00989199
RUN gpg --with-fingerprint --list-keys 0xC015E1AE00989199
#RUN gpg --verify gnuhealth-3.6.3.tar.gz.sig gnuhealth-3.6.3.tar.gz
RUN gpg --verify ${SIGFILE} ${DUMPFILE}

RUN tar xzf ${DUMPFILE}

WORKDIR /home/gnuhealth/${BASEFILE}

#RUN curl -SL https://ftp.gnu.org/gnu/health/gnuhealth-setup-latest.tar.gz | tar -xzvf -
#RUN curl -o ${SETUPFILE} -SL "https://ftp.gnu.org/gnu/health/$SETUPFILE"
#RUN tar -xzvf ${SETUPFILE}
COPY gnuhealth-setup gnuhealth-setup
USER root
RUN chmod +x gnuhealth-setup

USER gnuhealth

RUN ./gnuhealth-setup install



# Set the default command to run when starting
CMD [ "bash" ]
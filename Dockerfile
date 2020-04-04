FROM ubuntu:rolling
LABEL Description="Image for building kirat"

RUN apt update
RUN apt install -y libldap2-dev rng-tools libbz2-dev zlib1g-dev libsqlite3-dev libreadline-dev pcscd scdaemon
RUN apt install -y make wget file pinentry-tty ca-certificates lbzip2 bzip2 gcc
RUN apt clean

ARG GPG_VERSION=2.2.17
ENV GPG_VERSION "gnupg-$GPG_VERSION"

ADD ./download_and_compile.mk /app/
WORKDIR /app/

RUN make -f /app/download_and_compile.mk all

RUN gpg -K
ADD ./gpg-agent.conf ./scdaemon.conf /app/
COPY gpg-agent.conf /root/.gnupg/gpg-agent.conf
COPY scdaemon.conf /root/.gnupg/scdaemon.conf

# command GNUPG command
# CMD ["/bin/bash", "/app/start-within-container.sh"]


# Second batch
# Use base image
FROM postgres:latest

# Python 3 pip installation
RUN apt update
RUN apt install -y python3-pip
RUN pip3 --version

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Use our local cache
#RUN echo 'Acquire::http { Proxy "http://apt-cacher:9999"; };' >> /etc/apt/apt.conf.d/01proxy

ENV DUMPFILE="gnuhealth-latest.tar.gz"
#ENV DUMPFILE="gnuhealth-36rc3-demo.sql.gz"
#ENV SQLFILE="health301.sql"

VOLUME /var/lib/postgresql
RUN apt-get update && apt-get install -y --no-install-recommends gzip curl ca-certificates

RUN rm -rf /var/lib/apt/lists/*

RUN curl -o /$DUMPFILE -SL "https://ftp.gnu.org/gnu/health/$DUMPFILE"

#RUN adduser gnuhealth
#USER gnuhealth



# Set the default command to run when starting
CMD [ "bash" ]
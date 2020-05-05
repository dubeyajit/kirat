FROM dubeyajit/ubuntu-gnuhealth:v01
LABEL Description="Image for building kirat"

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
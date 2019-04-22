FROM ubuntu:16.04 

WORKDIR /app
ADD . /app

RUN \
  apt-get update \
  && apt-get install -y build-essential \
  && apt-get install -y python \
  && apt-get install -y octave \
  && apt-get install -y git

RUN \
  git clone https://github.com/MOcov/MOcov.git \
  && cd MOcov \
  && make install

ENTRYPOINT /bin/bash

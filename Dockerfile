# syntax=docker/dockerfile:1
FROM debian:bookworm-backports as build-system

WORKDIR /usr/src/app

COPY extras/klnagent.sh /usr/src/app

RUN apt update && \
    apt upgrade -y && \
    apt install -y vim && \
    chmod u+x klnagent.sh && \
    bash klnagent.sh && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

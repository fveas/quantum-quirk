# syntax=docker/dockerfile:1
FROM debian:bookworm-backports as build-system

WORKDIR /usr/src/app

COPY extras/klnagent64.sh /usr/src/app

RUN apt update && \
    apt upgrade -y && \
    apt install -y binutils \
    curl \
    vim \
    lsb-release \
    systemd \
    wget && \
    chmod u+x klnagent64.sh && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["/lib/systemd/systemd"]

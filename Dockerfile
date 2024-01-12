# syntax=docker/dockerfile:1
FROM python:3.12.1-slim-bookworm as build-system

WORKDIR /usr/src/app

COPY extras/klnagent64.sh /usr/src/app

RUN apt update && \
    apt upgrade -y && \
    apt install -y binutils \
    curl \
    vim \
    lsb-release \
    wget && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://packages.openvpn.net/packages-repo.gpg | tee /etc/apt/keyrings/openvpn.asc && \
    DISTRO=$(lsb_release -c | awk '{print $2}') && \
    echo "deb [signed-by=/etc/apt/keyrings/openvpn.asc] https://packages.openvpn.net/openvpn3/debian $DISTRO main" | tee /etc/apt/sources.list.d/openvpn-packages.list && \
    apt update && \
    apt install -y openvpn3 && \
    pip install --upgrade pip && \
    chmod u+x klnagent64.sh && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

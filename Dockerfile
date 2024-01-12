# syntax=docker/dockerfile:1
FROM python:3.12.1-slim-bookworm as build-system

WORKDIR /usr/src/app

RUN apt update && \
    apt upgrade -y && \
    apt install -y binutils \
    curl \
    vim \
    wget && \
    pip install --upgrade pip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

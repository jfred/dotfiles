#!/usr/bin/env bash
set -e

sudo apt-get update
sudo apt-get install \
    build-essential \
    curl \
    git \
    tig \
    m4 \
    ruby \
    texinfo \
    libbz2-dev \
    libcurl4-openssl-dev \
    libexpat-dev \
    libncurses-dev \
    zlib1g-dev \
    zsh

#!/usr/bin/env sh
# Prepare and run static analysis to the source
apk add \
    bash \
    gcc \
    git \
    libffi-dev \
    make \
    musl-dev \
    nodejs \
    npm \
    openssl-dev \
    py3-pip \
    python3 \
    python3-dev \
    shellcheck

# WORKAROUND:
# https://github.com/pypa/pip/issues/5247
pip3 install \
    --ignore-installed \
    pre-commit

pre-commit run \
    --all-files

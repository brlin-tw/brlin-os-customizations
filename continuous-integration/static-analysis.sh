#!/usr/bin/env sh
# Prepare and run static analysis to the source
# Copyright 2020 林博仁(Buo-ren Lin) <Buo.Ren.Lin@gmail.com>
# SPDX-License-Identifier: CC-BY-SA-4.0

set -eu

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

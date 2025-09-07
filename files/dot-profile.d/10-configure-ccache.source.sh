# shellcheck shell=sh
# Configure and use CCache to reduce software build time
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

if command -v ccache >/dev/null; then
    CC='ccache gcc'
    CXX='ccache g++'

    export \
        USE_CCACHE \
        CC \
        CXX
fi

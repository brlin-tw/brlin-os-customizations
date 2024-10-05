# shellcheck shell=sh
# Configure safe compiler flags
#
# References:
#
# * Safe CFLAGS - Gentoo Wiki
#   https://wiki.gentoo.org/wiki/Safe_CFLAGS
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

CFLAGS='-O2 -pipe -march=native'
CXXFLAGS="${CFLAGS}"

export CFLAGS CXXFLAGS

# shellcheck shell=sh
# Configure the Android build environment
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

# Use CCache when building Android
# https://source.android.com/source/initializing.html
if command -v ccache >/dev/null; then
    USE_CCACHE=1
    export USE_CCACHE
fi

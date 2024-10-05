# shellcheck shell=sh
# Configure my preferred plaintext document editor applications
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later
if command -v nano >/dev/null; then
    EDITOR=nano
    export EDITOR
fi

if command -v kwrite >/dev/null; then
    VISUAL=kwrite
    export VISUAL
fi

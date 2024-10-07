# shellcheck shell=bash
# Setup RVM
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

# Load RVM into a shell session *as a function*
if test -e "${HOME}/.rvm/scripts/rvm"; then
    # False positive: External resource
    # shellcheck source=/dev/null
    source "${HOME}/.rvm/scripts/rvm"
fi

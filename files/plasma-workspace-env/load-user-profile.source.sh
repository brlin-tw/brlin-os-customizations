# shellcheck shell=sh
# Workaround user profile settings not sourced in the KDE desktop environment
#
# Copyright 2025 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: CC-BY-SA-4.0

user_profile="${HOME}/.profile"

# FALSE POSITIVE: Out of scope
# shellcheck source=/dev/null
if test -e "${user_profile}"; then
    if ! . "${user_profile}"; then
        printf \
            'Error: Unable to source the user profile settings.\n' \
            1>&2
        return 2
    fi
fi

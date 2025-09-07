# shellcheck shell=sh
# Avoid buggy kf5 VCL plugin of LibreOffice-like software on certain systems
#
# Copyright 2025 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

# Unsupported OS
if ! test -f /etc/os-release; then
    return 0
fi

# Out of scope
# shellcheck source=/dev/null
if ! . /etc/os-release; then
    return 1
fi

# Unsupported OS
if test -z "${ID:+set}" \
    || test -z "${VERSION_ID:+set}"; then
    return 0
fi

if ! {
    test "${ID}" = ubuntu \
        && test "${VERSION_ID}" = 24.04
    }; then
    return 0
fi

if ! export SAL_USE_VCLPLUGIN=gtk3; then
    printf \
        'workaround-libreoffice-kf5vclplugin-bug.source.sh: Failed to export SAL_USE_VCLPLUGIN=gtk3\n' \
        >&2
    return 1
fi

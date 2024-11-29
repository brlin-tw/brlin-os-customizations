# shellcheck shell=bash
# Setup gpg-agent for PGP private key caching
#
# References:
#
# * Invoking GPG-AGENT (Using the GNU Privacy Guard)
#   https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

source_name="${BASH_SOURCE[0]}"

if ! command -v tty >/dev/null; then
    return 0
fi

if ! GPG_TTY="$(tty)"; then
    printf \
        '%s: Error: Unable to query the file name of the terminal connected to standard input.\n' \
        "${source_name}" \
        1>&2
    return 2
fi

export GPG_TTY

# shellcheck shell=sh
# Configure non-standard Tesseract Orange command search path
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

TESSERACT_ORANGE_VERSION=auto

if test "${TESSERACT_ORANGE_VERSION}" = auto; then
    # Detect existing Tesseract Orange installations
    set -- /opt/tesseract-orange-*

    # Bail out if no Tesseract Orange installation
    if test "${1}" = /opt/tesseract-orange-\*; then
        return
    fi
    tesseract_orange_prefix_dir="${1}"
else
    tesseract_orange_prefix_dir="/opt/tesseract-orange-${TESSERACT_ORANGE_VERSION}"
fi

tesseract_orange_executables_dir="${tesseract_orange_prefix_dir}/bin"

# Configure non-standard command search path
if test -e "${tesseract_orange_executables_dir}"; then
    if test -z "${PATH}"; then
        PATH="${tesseract_orange_executables_dir}"
    else
        if ! is_dir_in_paths "${tesseract_orange_executables_dir}" "${PATH}"; then
            PATH="${tesseract_orange_executables_dir}:${PATH}"
        fi
    fi
fi

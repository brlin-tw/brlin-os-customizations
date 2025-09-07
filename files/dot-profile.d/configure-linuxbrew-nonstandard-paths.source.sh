# shellcheck shell=sh
# Configure Linuxbrew non-standard paths
#
# Copyright 2025 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

linuxbrew_prefix="/home/linuxbrew/.linuxbrew"
linuxbrew_executables_dir="${linuxbrew_prefix}/bin"
linuxbrew_man_dir="${linuxbrew_prefix}/share/man"
linuxbrew_info_dir="${linuxbrew_prefix}/share/info"

if test -e "${linuxbrew_prefix}"; then
    if test -z "${PATH}"; then
        PATH="${linuxbrew_executables_dir}"
    else
        if ! is_dir_in_paths "${linuxbrew_executables_dir}" "${PATH}"; then
            PATH="${PATH}:${linuxbrew_executables_dir}"
        fi
    fi

    if test -z "${MANPATH}"; then
        MANPATH="${linuxbrew_man_dir}"
    else
        if ! is_dir_in_paths "${linuxbrew_man_dir}" "${MANPATH}"; then
            MANPATH="${linuxbrew_man_dir}:${MANPATH}"
        fi
    fi

    if test -z "${INFOPATH}"; then
        INFOPATH="${linuxbrew_info_dir}"
    else
        if ! is_dir_in_paths "${linuxbrew_info_dir}" "${INFOPATH}"; then
            INFOPATH="${linuxbrew_info_dir}:${INFOPATH}"
        fi
    fi

    export PATH MANPATH INFOPATH
fi

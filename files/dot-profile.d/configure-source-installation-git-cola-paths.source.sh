# shellcheck shell=sh
# Configure Git Cola source installation paths
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

git_cola_source_dir="${HOME}/文件/自由知識創作平台/版本控制 Version control/Git 版本控制系統/Git Cola/上游專案"

if ! test -e "${git_cola_source_dir}"; then
    return
fi

# Git submodule content may not be checked out
set -- "${git_cola_source_dir}/"*
if test "${#}" = "${git_cola_source_dir}/*"; then
    return
fi

git_cola_source_executables_dir="${git_cola_source_dir}/bin"
git_cola_source_data_dir="${git_cola_source_dir}/share"

if test -z "${XDG_DATA_DIRS}"; then
    # If $XDG_DATA_DIRS is either not set or empty, a value equal to /usr/local/share/:/usr/share/ should be used.
    # Environment variables | XDG Base Directory Specification
    # https://specifications.freedesktop.org/basedir-spec/latest/index.html#variables
    XDG_DATA_DIRS="${git_cola_source_data_dir}:/usr/local/share/:/usr/share/"
    export XDG_DATA_DIRS
else
    if ! is_dir_in_paths "${git_cola_source_data_dir}" "${XDG_DATA_DIRS}"; then
        XDG_DATA_DIRS="${git_cola_source_data_dir}:${XDG_DATA_DIRS}"
    fi
fi

if ! is_dir_in_paths "${git_cola_source_executables_dir}" "${PATH}"; then
    PATH="${git_cola_source_executables_dir}:${PATH}"
fi

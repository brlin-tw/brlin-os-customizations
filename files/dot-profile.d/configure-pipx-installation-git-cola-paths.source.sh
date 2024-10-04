# shellcheck shell=sh
# Configure Git Cola pipx installation paths
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

git_cola_pipx_data_dir="${HOME}/.local/pipx/venvs/git-cola/share"
if ! test -e "${git_cola_pipx_data_dir}"; then
    return
fi

if test -z "${XDG_DATA_DIRS}"; then
    # If $XDG_DATA_DIRS is either not set or empty, a value equal to /usr/local/share/:/usr/share/ should be used.
    # Environment variables | XDG Base Directory Specification
    # https://specifications.freedesktop.org/basedir-spec/latest/index.html#variables
    XDG_DATA_DIRS="${git_cola_pipx_data_dir}:/usr/local/share/:/usr/share/"
    export XDG_DATA_DIRS
else
    if is_dir_in_paths "${git_cola_pipx_data_dir}" "${XDG_DATA_DIRS}"; then
        # Already set elsewhere
        return
    fi
    XDG_DATA_DIRS="${git_cola_pipx_data_dir}:${XDG_DATA_DIRS}"
fi

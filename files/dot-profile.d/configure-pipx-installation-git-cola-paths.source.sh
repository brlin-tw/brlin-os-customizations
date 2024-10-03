# shellcheck shell=sh
# Configure Git Cola pipx installation paths
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

## Check if the dir is already in paths
is_dir_in_paths(){
    if test "${#}" -ne 2; then
        printf \
            'is_dir_in_paths: Error: This function should have 2 arguments, only %s is specified.\n' \
            "${#}" \
            1>&2
        return 2
    fi

    dir="${1}"; shift
    paths="${1}"; shift

    # Backup IFS
    IFS_ORIGINAL="${IFS}"
    IFS=":"

    path_found=false
    for path in ${paths}; do
        if [ "${dir}" = "${path}" ]; then
            path_found=true
            break
        fi
    done

    # Restore IFS
    IFS="${IFS_ORIGINAL}"

    if test "${path_found}" = false; then
        return 1
    else
        return 0
    fi
}

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

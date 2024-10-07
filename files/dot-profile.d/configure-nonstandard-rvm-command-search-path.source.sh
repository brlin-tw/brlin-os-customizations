# shellcheck shell=sh
# Configure non-standard RVM command search path
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

rvm_executables_dir="${HOME}/.rvm/bin"

# Configure non-standard command search path
if test -e "${rvm_executables_dir}"; then
    if test -z "${PATH}"; then
        PATH="${rvm_executables_dir}"
    else
        if ! is_dir_in_paths "${rvm_executables_dir}" "${PATH}"; then
            # RVM requires its path to be at the last entry for some reason
            PATH="${PATH}:${rvm_executables_dir}"
        fi
    fi
fi

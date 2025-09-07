# shellcheck shell=sh
# Configure Haskell Cabal
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

cabal_executables_dir="${HOME}/.cabal/bin"

# Configure Haskell Cabal non-standard command search path
if test -e "${cabal_executables_dir}"; then
    if test -z "${PATH}"; then
        PATH="${cabal_executables_dir}"
    else
        if ! is_dir_in_paths "${cabal_executables_dir}" "${PATH}"; then
            PATH="${cabal_executables_dir}:${PATH}"
        fi
    fi
fi

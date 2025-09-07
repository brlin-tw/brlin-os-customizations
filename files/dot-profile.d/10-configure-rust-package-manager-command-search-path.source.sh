# shellcheck shell=sh
# Configure ‎the Rust package manager command search path
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

cargo_executable_dir="${HOME}/.cargo/bin"
if test -e "${cargo_executable_dir}" \
    && ! is_dir_in_paths "${cargo_executable_dir}" "${PATH}"; then
    PATH="${cargo_executable_dir}:${PATH}"
fi

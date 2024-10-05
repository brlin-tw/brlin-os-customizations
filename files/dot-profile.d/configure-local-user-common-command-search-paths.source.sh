# shellcheck shell=sh
# Configure common command search paths for the local user

# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

# Setup several common executable directories under user prefix directory
install_executable_search_path "${HOME}/.local/bin"
install_executable_search_path "${HOME}/.local/sbin"
install_executable_search_path "${HOME}/bin"
install_executable_search_path "${HOME}/sbin"

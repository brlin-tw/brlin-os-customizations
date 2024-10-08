# shellcheck shell=sh
# Configure RubyGems packages installations in the local user
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

# Install Ruby Gems to ~/.gems
GEM_HOME="${HOME}/.gems"
export GEM_HOME

gem_executables_dir="${GEM_HOME}/bin"

if ! test -e "${gem_executables_dir}"; then
    return 0
fi

if test -z "${PATH}"; then
    PATH="${gem_executables_dir}"
    export PATH
else
    if ! is_dir_in_paths "${gem_executables_dir}" "${PATH}"; then
        PATH="${gem_executables_dir}:${PATH}"
    fi
fi

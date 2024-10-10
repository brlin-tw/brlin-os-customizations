# shellcheck shell=sh
# Configure non-standard ROCm command search path
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

ROCM_VERSION=auto

if test "${ROCM_VERSION}" = auto; then
    # Detect existing ROCm installations
    set -- /opt/rocm-*

    # Bail out if no ROCm installation
    if test "${1}" = /opt/rocm-\*; then
        return
    fi
    rocm_prefix_dir="${1}"
else
    rocm_prefix_dir="/opt/rocm-${ROCM_VERSION}"
fi

rocm_executables_dir="${rocm_prefix_dir}/bin"

# Configure non-standard command search path
if test -e "${rocm_executables_dir}"; then
    if test -z "${PATH}"; then
        PATH="${rocm_executables_dir}"
    else
        if ! is_dir_in_paths "${rocm_executables_dir}" "${PATH}"; then
            PATH="${rocm_executables_dir}:${PATH}"
        fi
    fi
fi

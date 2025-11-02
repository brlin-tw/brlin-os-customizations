# shellcheck shell=sh
# Configure local JDK installation
#
# Copyright 2025 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: MIT

jdk_prefix_dir="${HOME}/應用軟體/jdk-24"

if test -d "${jdk_prefix_dir}"; then
    export JAVA_HOME="${jdk_prefix_dir}"
    export PATH="${JAVA_HOME}/bin:${PATH}"
fi

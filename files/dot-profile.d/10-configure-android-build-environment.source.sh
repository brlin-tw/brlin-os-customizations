# shellcheck shell=sh
# Configure the Android build environment
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

# Use CCache when building Android
# https://source.android.com/source/initializing.html
if command -v ccache >/dev/null; then
    USE_CCACHE=1
    export USE_CCACHE
fi

# Resolve the following error message during build:
#
#    JAVA_HOME is not set.
#    Please set JAVA_HOME so that switching between Android Studio and the terminal does not trigger a full rebuild."
#
studio_prefix="${HOME}/應用軟體/android-studio"
studio_java_dir="${studio_prefix}/jbr"
if test -e "${studio_java_dir}"; then
    JAVA_HOME="${studio_java_dir}"
    export JAVA_HOME
fi

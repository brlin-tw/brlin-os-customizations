# shellcheck shell=sh
# Workaround inability to use the Fcitx input method framework in some applications in the Wayland session.
#
# Copyright 2025 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: CC-BY-SA-4.0

# If the environment variable is already set, another input method may be using
if test -n "${GTK_IM_MODULE}"; then
    return 0
fi

# Not wayland
if test "${XDG_SESSION_TYPE}" != "wayland"; then
    return 0
fi

GTK_IM_MODULE=fcitx
export GTK_IM_MODULE

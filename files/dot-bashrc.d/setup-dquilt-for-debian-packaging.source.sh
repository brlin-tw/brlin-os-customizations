# shellcheck shell=bash
# shellcheck disable=SC2034
# Setup dquilt for debian packaging
# Refer: https://www.debian.org/doc/manuals/maint-guide/modify.zh-tw.html
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

# Don't bother if the quilt command is not installed
if ! command quilt >/dev/null; then
    return 0
fi

alias dquilt='quilt --quiltrc=${HOME}/.quiltrc-dpkg'
complete -F _quilt_completion -o filenames dquilt

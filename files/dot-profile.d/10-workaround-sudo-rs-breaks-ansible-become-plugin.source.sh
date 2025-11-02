# shellcheck shell=sh
# Workaround the Rust implementation of sudo in Ubuntu 25.10 breaking
# Ansible's become plugin when using sudo for privilege escalation.
#
# References:
#
# * Bug #2122414 “Ansible times out after BECOME password request” : Bugs : rust-sudo-rs package : Ubuntu
#   https://bugs.launchpad.net/ubuntu/+source/rust-sudo-rs/+bug/2122414
# * validate sudo become plugin against sudo-rs · Issue #85837 · ansible/ansible
#   https://github.com/ansible/ansible/issues/85837
#
# Copyright 2025 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

# Out of scope
# shellcheck source=/dev/null
if ! . /etc/os-release; then
    printf \
        'Error: %s: Failed to source /etc/os-release.\n' \
        "${0}" \
        >&2
    return 1
fi

if test "${ID}" = ubuntu && test "${VERSION_ID}" = 25.10; then
    export ANSIBLE_BECOME_EXE=sudo.ws
fi

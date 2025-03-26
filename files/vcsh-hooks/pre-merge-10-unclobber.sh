#!/usr/bin/env bash
# Move existing vcsh managed config files out of the way.
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: CC-BY-SA-4.0

set_opts=(
    # Terminate script execution when an unhandled error occurs
    -o errexit
    -o errtrace

    # Terminate script execution when an unset parameter variable is
    # referenced
    -o nounset
)
if ! set "${set_opts[@]}"; then
    printf \
        'Error: Unable to configure the defensive interpreter behaviors.\n' \
        1>&2
    exit 1
fi

required_commands=(
    date
    git
    mv
    realpath
)
flag_required_command_check_failed=false
for command in "${required_commands[@]}"; do
    if ! command -v "${command}" >/dev/null; then
        flag_required_command_check_failed=true
        printf \
            'Error: This program requires the "%s" command to be available in your command search PATHs.\n' \
            "${command}" \
            1>&2
    fi
done
if test "${flag_required_command_check_failed}" == true; then
    printf \
        'Error: Required command check failed, please check your installation.\n' \
        1>&2
    exit 1
fi

if test -v BASH_SOURCE; then
    # Convenience variables may not need to be referenced
    # shellcheck disable=SC2034
    {
        if ! script="$(
            realpath \
                --strip \
                "${BASH_SOURCE[0]}"
            )"; then
            printf \
                'Error: Unable to determine the absolute path of the program.\n' \
                1>&2
            exit 1
        fi
        script_dir="${script%/*}"
        script_filename="${script##*/}"
        script_name="${script_filename%%.*}"
    }
fi
# Convenience variables may not need to be referenced
# shellcheck disable=SC2034
{
    script_basecommand="${0}"
    script_args=("${@}")
}

if ! trap trap_err ERR; then
    printf \
        'Error: Unable to set the ERR trap.\n' \
        1>&2
    exit 1
fi

git_branch_opts=(
    # List both remote-tracking branches and local branches
    --all
)
if ! remote_branch="$(git branch "${git_branch_opts[@]}")"; then
    printf \
        '%s: Error: Unable to query the remote branch.\n' \
        "${script_name}" \
        1>&2
    exit 2
fi
vcsh_branch="${remote_branch#*remotes/origin/}"

git_lstree_opts=(
    # Recurse into sub-trees
    -r

    # List only filenames
    --name-only

    # Output null-terminated filenames to avoid special filenames
    -z
)
mapfile_opts=(
    # Strip trailing line-endings
    -t

    # Input data is null-terminated
    -d ''
)
if ! mapfile "${mapfile_opts[@]}" files < <(
    git ls-tree \
        "${git_lstree_opts[@]}" \
        "origin/${vcsh_branch}"
    ); then
    printf \
        '%s: Error: Unable to load Git tree files.\n' \
        "${script_name}" \
        1>&2
    exit 2
fi

if ! operation_timestamp="$(
    date +%Y%m%d-%H%M%S
    )"; then
    printf \
        '%s: Error: Unable to generate the operation timestamp.\n' \
        "${script_name}" \
        1>&2
    exit 2
fi

for file in "${files[@]}"; do
    if ! test -e "${file}"; then
        continue
    fi

    backup_file="${file}.orig.${operation_timestamp}"
    printf \
        '%s: Warning: Moving pre-existing config file "%s" to "%s".\n' \
        "${script_name}" \
        "${file}" \
        "${backup_file}" \
        1>&2
    if ! mv "${file}" "${backup_file}"; then
        printf \
            '%s: Error: Failed to move the "%s" file to its backup location.\n' \
            "${script_name}" \
            "${file}" \
            1>&2
        exit 2
    fi
done

#!/usr/bin/env bash
# Query all vcsh configuration repositories owned by Buo-ren, Lin
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
    # For calling GitHub REST APIs
    curl

    # For parsing GitHub RESST APIs
    jq

    # For querying the absolute path of this program
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

# FIXME: Pagination is not implemented.
curl_opts=(
    # Follow redirects
    --location

    # Specify conforming GitHub API version
    --header "X-GitHub-Api-Version: 2022-11-28"

    # Specify expected response type
    --header "Accept: application/vnd.github+json"

    # Return non zero exit status when receiving error response
    --fail

    # Don't print progress report except for errors
    --silent
    --show-error
)
if ! vcsh_repos_raw="$(
    curl "${curl_opts[@]}" "https://api.github.com/search/repositories?q=vcsh-%20in:name%20user:brlin-tw&per_page=100"
    )"; then
    printf \
        'Error: Unable to query vcsh repositories of Buo-ren, Lin.\n' \
        1>&2
    exit 2
fi

jq_opts=(
    # Don't quote query result strings
    --raw-output
)
if ! jq "${jq_opts[@]}" .items[].name <<<"${vcsh_repos_raw}"; then
    printf \
        'Error: Unable to parse out the repository names from the GitHub API response.\n' \
        1>&2
    exit 2
fi

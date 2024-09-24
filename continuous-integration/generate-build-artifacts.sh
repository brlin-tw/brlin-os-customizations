#!/usr/bin/env bash
# Generate the project build artifacts
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: CC-BY-SA-4.0
set \
    -o errexit \
    -o nounset

if ! shopt -s nullglob; then
    printf \
        'Unable to set the nullglob shell option.\n' \
        1>&2
fi

script="${BASH_SOURCE[0]}"
if ! script="$(
    realpath \
        --strip \
        "${script}"
    )"; then
    printf \
        'Error: Unable to determine the absolute path of the program.\n' \
        1>&2
    exit 1
fi

script_dir="${script%/*}"

if ! test -e "${script_dir}/venv"; then
    printf \
        'Info: Initializing the Python virtual environment...\n'
    if ! python3 -m venv "${script_dir}/venv"; then
        printf \
            'Error: Unable to initialize the Python virtual environment.\n' \
            1>&2
        exit 2
    fi
fi

printf \
    'Info: Activating the Python virtual environment...\n'
# Out of scope
# shellcheck source=/dev/null
if ! source "${script_dir}/venv/bin/activate"; then
    printf \
        'Error: Unable to activate the Python virtual environment.\n' \
        1>&2
    exit 2
fi

printf \
    'Info: Installing git-archive-all...\n'
if ! pip show git-archive-all &>/dev/null; then
    if ! pip install git-archive-all; then
        printf \
            'Error: Unable to install git-archive-all.\n' \
            1>&2
        exit 2
    fi
fi

printf \
    'Info: Determining the project version...\n'
git_describe_opts=(
    --always
    --dirty
    --tags
)
if ! version_describe="$(
    git describe \
        "${git_describe_opts[@]}"
    )"; then
    printf \
        'Error: Unable to determine the project version.\n' \
        1>&2
    exit 2
fi
project_version="${version_describe#v}"

printf \
    'Info: Generating the project archive...\n'
project_id="${CI_PROJECT_NAME:-"${project_id}"}"
release_id="${project_id}-${project_version}"
uncompressed_project_archive="${release_id}.tar"
git_archive_all_opts=(
    # Add an additional layer of folder for containing the archive
    # contents
    --prefix="${release_id}/"
)
if ! \
    git-archive-all \
        "${git_archive_all_opts[@]}" \
        "${uncompressed_project_archive}"; then
    printf \
        'Error: Unable to generate the project archive.\n' \
        1>&2
    exit 2
fi

printf \
    'Info: Fetching external Ansible assets...\n'
ansible_galaxy_opts=(
    # Specify requirements file to fetch external assets from
    -r requirements.yml
)
if ! ansible-galaxy install "${ansible_galaxy_opts[@]}"; then
    printf \
        'Error: Unable to fetch external Ansible assets.\n'
    exit 2
fi

printf \
    'Info: Injecting external Ansible resources...\n'
for role in playbooks/roles/*/; do
    role_dir="${role%/}"
    role_name="${role_dir##*/}"
    printf \
        'Info: Injecting the %s role to the release archive...\n' \
        "${role_name}"
    tar_opts=(
        # Add files to an existing archive
        --append

        # Transform member names to fit into release prefix
        --transform="flags=rSH;s@^@${release_id}/@x"

        # Show namae transformation results
        --show-transformed-names

        # Specify archive to operate on
        --file="${uncompressed_project_archive}"

        # Print names appended in the tar archive
        --verbose
    )
    if ! tar "${tar_opts[@]}" "${role_dir}"; then
        printf \
            'Error: Unable to inject the %s role to the release archive...\n' \
            "${role_name}"
        exit 2
    fi
done

for collection_dir in playbooks/collections/ansible_collections/*/; do
    collection_dir="${collection_dir%/}"
    printf \
        'Info: Injecting the %s collection directory to the release archive...\n' \
        "${collection_dir}"
    tar_opts=(
        # Add files to an existing archive
        --append

        # Transform member names to fit into release prefix
        --transform="flags=rSH;s@^@${release_id}/@x"

        # Show namae transformation results
        --show-transformed-names

        # Specify archive to operate on
        --file="${uncompressed_project_archive}"

        # Print names appended in the tar archive
        --verbose
    )
    if ! tar "${tar_opts[@]}" "${collection_dir}"; then
        printf \
            'Error: Unable to inject the %s collection directory to the release archive...\n' \
            "${collection_dir}"
        exit 2
    fi
done

printf \
    'Info: Compressing the release archive...\n'
gzip_opts=(
    # Overwrite existing files
    --force

    --verbose
)
if ! gzip "${gzip_opts[@]}" "${uncompressed_project_archive}"; then
    printf \
        'Error: Unable to compress the release archive.\n' \
        1>&2
    exit 2
fi

printf \
    'Info: Operation completed without errors.\n'

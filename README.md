# Buo-ren, Lin's OS Customizations

This project provides personally preferred operating system customizations, for convenience after re-installing the system.

Via the use of Ansible automation, it should be able to extend it to other OS distributions.

<https://gitlab.com/brlin/brlin-os-customizations>  
[![The GitLab CI pipeline status badge of the project's `main` branch](https://gitlab.com/brlin/brlin-os-customizations/badges/main/pipeline.svg?ignore_skipped=true "Click here to check out the comprehensive status of the GitLab CI pipelines")](https://gitlab.com/brlin/brlin-os-customizations/-/pipelines) [![GitHub Actions workflow status badge](https://github.com/brlin-tw/brlin-os-customizations/actions/workflows/check-potential-problems.yml/badge.svg "GitHub Actions workflow status")](https://github.com/brlin-tw/brlin-os-customizations/actions/workflows/check-potential-problems.yml) [![pre-commit enabled badge](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white "This project uses pre-commit to check potential problems")](https://pre-commit.com/) [![REUSE Specification compliance badge](https://api.reuse.software/badge/gitlab.com/brlin/brlin-os-customizations "This project complies to the REUSE specification to decrease software licensing costs")](https://api.reuse.software/info/gitlab.com/brlin/brlin-os-customizations)

## Dependencies

* [Ansible](https://ansible.com)

## How to use

1. Download the release archive from [the project's Releases page](https://gitlab.com/brlin/brlin-os-customizations/-/releases)
1. Extract the downloaded release archive
1. Launch a text terminal application
1. In the text terminal application, change the working directory to the extracted project folder
1. Run the following command to execute [the customization playbook](playbooks/apply-customizations.yml) and provide your sudo password on prompt:

    ```bash
    ansible_playbook_opts=(
        # Ask the user's become password
        --ask-become-pass
    )
    ansible-playbook \
        "${ansible_playbook_opts[@]}" \
        playbooks/apply-customizations.yml
    ```

   If you intend to use [the remotehost inventory](inventory/remotehost/main.yml), add the `-i inventory/remotehost` command option and argument to the `ansible_playbook_opts` array definition, note that in this case the system will automatically reboot to apply the changes while running [the customization apply playbook](playbooks/apply-customizations.yml).

1. (If using the localhost inventory) Reboot the system to apply the changes

## References

The following external materials are reference during the development of this project:

* [Ubuntu Flathub Setup | Flathub](https://flathub.org/setup/Ubuntu)  
  For the setup instructions of the Flatpak runtime on Ubuntu.
* [community.general.flatpak_remote module – Manage flatpak repository remotes — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/community/general/flatpak_remote_module.html)  
  Explains how to use the `community.general.flatpak_remote` module to setup up the Flathub software source.

## Licensing

Unless otherwise noted(individual file's header/[REUSE DEP5](.reuse/dep5)), this product is licensed under [the 4.0 International version of the Creative Commons Attribution-ShareAlike license(CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/), or any of its recent versions you would prefer.

This work complies to the [REUSE Specification](https://reuse.software/spec/), refer the [REUSE - Make licensing easy for everyone](https://reuse.software/) website for info regarding the licensing of this product.

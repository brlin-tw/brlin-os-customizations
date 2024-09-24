# Buo-ren, Lin's OS customizations

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
* [community.general.dconf module – Modify and read dconf database — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/community/general/dconf_module.html)  
  Explains how to use the `community.general.dconf module` module to configure input method settings.
* [Linux_Downloads – Oracle VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads)  
  Explains the supported GNU+Linux distributions of the official Oracle VirtualBox packages distribution.
* [ansible/lib/ansible/module_utils/facts/system/distribution.py at aa24e97 · ansible/ansible](https://github.com/ansible/ansible/blob/aa24e97/lib/ansible/module_utils/facts/system/distribution.py)  
  Explains the logic of determine the value of the `ansible_distribution` Ansible fact variable.
* [Detect Latest VirtualBox Version | ChatGPT](https://chatgpt.com/share/66f14139-7358-8012-9cd6-022cd4c0bdff)  
  Explains how to programmatically detect the latest released version of Oracle VirtualBox without installing the application.
* [ansible.builtin.uri module – Interacts with webservices — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/uri_module.html#return-values)  
  Explains how to use the `ansible.builtin.uri` module to access the version string of the latest Oracle VirtualBox release.
* [ansible.builtin.set_fact module – Set host variable(s) and fact(s). — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/set_fact_module.html)  
  Explains how to use the `ansible.builtin.set_fact` module to set a managed node variable.

## Licensing

Unless otherwise noted(individual file's header/[REUSE DEP5](.reuse/dep5)), this product is licensed under [the 4.0 International version of the Creative Commons Attribution-ShareAlike license(CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/), or any of its recent versions you would prefer.

This work complies to the [REUSE Specification](https://reuse.software/spec/), refer the [REUSE - Make licensing easy for everyone](https://reuse.software/) website for info regarding the licensing of this product.

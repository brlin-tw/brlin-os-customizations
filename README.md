# OS customizations of Buo-ren Lin

This project provides personally preferred operating system customizations, for convenience after re-installing the system.

Via the use of Ansible automation, it should be able to extend it to other OS distributions.

<https://gitlab.com/brlin/brlin-os-customizations>  
[![The GitLab CI pipeline status badge of the project's `main` branch](https://gitlab.com/brlin/brlin-os-customizations/badges/main/pipeline.svg?ignore_skipped=true "Click here to check out the comprehensive status of the GitLab CI pipelines")](https://gitlab.com/brlin/brlin-os-customizations/-/pipelines) [![GitHub Actions workflow status badge](https://github.com/brlin-tw/brlin-os-customizations/actions/workflows/check-potential-problems.yml/badge.svg "GitHub Actions workflow status")](https://github.com/brlin-tw/brlin-os-customizations/actions/workflows/check-potential-problems.yml) [![pre-commit enabled badge](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white "This project uses pre-commit to check potential problems")](https://pre-commit.com/) [![REUSE Specification compliance badge](https://api.reuse.software/badge/gitlab.com/brlin/brlin-os-customizations "This project complies to the REUSE specification to decrease software licensing costs")](https://api.reuse.software/info/gitlab.com/brlin/brlin-os-customizations)

## Prerequisites

The following prerequisites must be met in order to use this solution:

Your Ansible controller host must install the following software:

* [Ansible](https://ansible.com)  
  For running deployment Ansible playbooks.
* sshpass  
  For supporting Ansible managed hosts that uses SSH password authentication.

Your Ansible managed nodes to deploy must satisfy the following requirements:

* Currently only Ubuntu 24.04 is supported.
* It must be accessible from the Ansible controller host via the SSH protocol, as an exception you can also use the managed node itself as the Ansible controller host.
* It must have access to the Internet.

## How to use

1. Download the release archive from [the project's Releases page](https://gitlab.com/brlin/brlin-os-customizations/-/releases)
1. Extract the downloaded release archive
1. Launch a text terminal application
1. In the text terminal application, change the working directory to the extracted project folder
1. Run the following commands to execute [the customization playbook](playbooks/apply-customizations.yml) and provide your sudo password on prompt:

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

## Variables to customize the playbooks' behaviors

The following host variables can customize the playbooks' behaviors.

You can specify it by using the `-e` `ansible-playbook` command option or by directly edit the inventory/playbook.

### brlinos_skip_upgrade

Skip the full system upgrade process, this is useful in subsequent deployment, to avoid disrupting the user session.

**Supported values:**

* `true`: Skip upgrade.
* `false`: Don't skip upgrade.

**Default value:** `false`

### brlinos_skip_software_installation

Skip the lengthy preferred software installation process, this is useful if you only want to do the configuration portion of the play.

**Supported values:**

* `true`: Skip software installation.
* `false`: Don't skip software installation.

**Default value:** `false`

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
* [Grammar — JMESPath Specification — JMESPath](https://jmespath.org/specification.html#grammar)  
  Explains the grammar of the `literal` and `json-value` values.
* [ends_with — Built-in Functions — JMESPath Specification — JMESPath](https://jmespath.org/specification.html#ends-with)  
  Explains the usage of the `ends_with` built-in function.
* [Examples – ansible.builtin.get_url module – Downloads files from HTTP, HTTPS, or FTP to node — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/get_url_module.html#examples)  
  Explains the usage of the ansible.builtin.get_url Ansible module.
* [extra_opts – Parameters – ansible.builtin.unarchive module – Unpacks an archive after (optionally) copying it from the local machine — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/unarchive_module.html#parameter-extra_opts)  
  Explains the usage of the `extra_opts` parameter of the ansible.builtin.unarchive Ansible module.
* [ansible.builtin.tempfile module – Creates temporary files and directories — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/tempfile_module.html)  
  Explains how to create a temporary directory using the ansible.builtin.tempfile Ansible module.
* [KConfig - KConfig Entry Options](https://api.kde.org/frameworks/kconfig/html/options.html)  
  Explains the effect of the `$e` configuration entry marking of a KDE KConfig configuration file.

## Licensing

Unless otherwise noted(individual file's header/[REUSE DEP5](.reuse/dep5)), this product is licensed under [the 4.0 International version of the Creative Commons Attribution-ShareAlike license(CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/), or any of its recent versions you would prefer.

This work complies to the [REUSE Specification](https://reuse.software/spec/), refer the [REUSE - Make licensing easy for everyone](https://reuse.software/) website for info regarding the licensing of this product.

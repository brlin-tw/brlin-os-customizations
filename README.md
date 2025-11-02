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
* [`jmespath` PyPI package](https://pypi.org/project/jmespath/)  
  For parsing JSON data from responses of the GitHub APIs.
* [sshpass](https://sourceforge.net/projects/sshpass/)  
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
1. Run the following commands to execute [the customization playbook](playbooks/apply-customizations.yml) and provide your sudo password and Ansible vault decryption password on prompt:

    ```bash
    ansible_playbook_opts=(
        # Ask the user's become password
        --ask-become-pass

        # Ask for the user's Ansible vault decryption password
        --ask-vault-pass
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

### brlinos_apply_flash_storage_workarounds

Whether to apply flash storage drive workarounds to enable TRIM-like support of certain drives on Linux.

As wrongly apply workaround on drives with faulty TRIM-like command translation implementations this may cause data loss, users should evaluate the risk before enabling this option.

**Supported values:**

* `true`: Apply workarounds.
* `false`: Don't apply workarounds.

**Default value:** `false`

## Development

This section documents helpful information in developing this project:

### Detecting configuration file responsible for a specific configuration

Use the inotifywait command from [the inotify-tools package](https://github.com/inotify-tools/inotify-tools/wiki) to detect which file has been modified during a configuration change:

```bash
inotifywait \
    --monitor \
    --event close_write \
    --recursive \
    ~/.config
```

For files in a BTRFS filesystem that are indicated with inode number instead of file path in the `inotifywait` command's output, you can query the real path by running the following command _as root_:

```bash
btrfs inspect-internal inode-resolve _inode_num_ _mountpoint_
```

, where the _mountpoint_ placeholder should be replaced with the BTRFS volume mountpoint that contain the file.

### Detecting GSettings key responsible for a specific configuration

Run the following command to detect which GSettings key has been modified during a configuration change:

```bash
gsettings monitor _schema_
```

You'll need to know the GSettings schema this key belong to before monitoring it, run the following command to determine the correct schema:

```bash
gsettings list-schemas
```

### Detecting dconf key responsible for a specific configuration

Run the following command to detect which dconf key has been modified during a configuration change:

```bash
dconf watch /
```

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
* [apply - Parameters - ansible.builtin.include_role module – Load and execute a role — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/include_role_module.html#parameter-apply)  
  Explains how to apply task keywords to the included role.
* The inotifywait(1) manual page  
  Explains how to use the `inotifywait` command to determine which configuration file to modify to change the desired settings.
* [How to find the file at a certain btrfs inode - Server Fault](https://serverfault.com/questions/746938/how-to-find-the-file-at-a-certain-btrfs-inode)  
  Explains how to query the corresponding file path from a BTRFS filesystem inode number.
* [Session Environment Variables - KDE UserBase Wiki](https://userbase.kde.org/Session_Environment_Variables)  
  Explains how to set environment variables in a KDE session.
* The output of the `kreadconfig5 --help` command.  
  Explains how to use the `kreadconfig5` command to query certain KDE configuration settings.
* The output of the `kwriteconfig5 --help` command.  
  Explains how to use the `kwriteconfig5` command to set certain KDE configuration settings.
* [community.general.xml module – Manage bits and pieces of XML files or strings — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/community/general/xml_module.html)  
  Explains how to manipulate XML document in an Ansible playbook.
* [ansible.builtin.fileglob lookup – list files matching a pattern — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/fileglob_lookup.html)  
  Explains how to use the `ansible.builtin.fileglob` lookup plugin to list files matching a pattern.
* [Chapter 14. Configuring NetworkManager to ignore certain devices | Configuring and managing networking | Red Hat Enterprise Linux | 8 | Red Hat Documentation](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/configuring-networkmanager-to-ignore-certain-devices_configuring-and-managing-networking)  
  Explains how to configure NetworkManager to ignore specific network devices.
* [community.general.npm module – Manage node.js packages with npm — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/community/general/npm_module.html)  
  Explains how to manage NPM global packages in Ansible.
* [ansible.builtin.version test – compare version strings — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/version_test.html)  
  Explains how to use compare two version strings in Ansible.
* [community.general.locale_gen module – Creates or removes locales — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/community/general/locale_gen_module.html)  
  Explains how to configure locale settings on Debian-based OS distributions.
* [My reply in Request adding documentation on how to configure the system/user locale · Issue #2885 · rocky-linux/documentation](https://github.com/rocky-linux/documentation/issues/2885#issuecomment-3477637438)  
  Explains how to configure locale settings on RedHat-based OS distributions.
* [community.general.snap module – Manages snaps — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/community/general/snap_module.html)  
  Explains how to install snap package against certain channel using the `community.general.snap` module.

## Licensing

Unless otherwise noted(individual file's header/[REUSE DEP5](.reuse/dep5)), this product is licensed under [the 4.0 International version of the Creative Commons Attribution-ShareAlike license(CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/), or any of its recent versions you would prefer.

This work complies to the [REUSE Specification](https://reuse.software/spec/), refer the [REUSE - Make licensing easy for everyone](https://reuse.software/) website for info regarding the licensing of this product.

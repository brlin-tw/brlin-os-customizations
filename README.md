# Buo-ren, Lin's OS Customizations

This project provides personally preferred operating system customizations, for convenience after re-installing the system.

Via the use of Ansible automation, it should be able to extend it to other OS distributions.

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

## License

Unless otherwise specified, this work is licensed with Creative Commons CC-BY-SA 4.0, or any recent version you preferred.

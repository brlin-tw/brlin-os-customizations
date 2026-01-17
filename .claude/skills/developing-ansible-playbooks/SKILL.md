---
name: developing-ansible-playbooks
description: Provide guidelines on how to develop Ansible playbooks that are compliant with project standards. Should be used when generating, modifying, or reviewing Ansible playbooks, roles, or collections.
---

# The developing-ansible-playbooks skill

This skill provides guidelines on how to develop Ansible playbooks that are compliant with project standards. Should be used when generating, modifying, or reviewing Ansible playbooks, roles, or collections.

## Rule of thumb

If the Ansible playbook, role, or collection being developed has existing examples in the project repository, always refer to those examples and mimic their style and structure to ensure consistency.

If there are no existing examples in the project repository, refer to the following guidelines:

## Task structure

The following structure should be followed for each task in the Ansible playbook:

* The `when` key should be placed at the start of the task, right after the `name` key.
* **The module name should always be the last key of the task.**
* The fully qualified collection name (FQCN) form should always be used.
* If the `become` key is used, it should be placed right after the `when` key.
* The `become` key is mandatory for tasks that require elevated privileges.
* Ansible fact references should use the `ansible_facts` prefix (e.g., `ansible_facts['os_family']` instead of `ansible_os_family`).
* Use `loop` instead of `with_items` for iterating over lists.
* When loops are used, customize the loop variable name using `loop_control` for better readability.
* Always use `true` and `false` for boolean values.

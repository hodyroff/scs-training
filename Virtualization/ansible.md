## Ansible 1x2

### Ansible concepts
* Ansible is a configuration management system that uses ssh to connect to managed nodes (agent-less)
* These are kept track of in an inventory
* Gathered information on those nodes are called facts
* Ansible is run from the control node (in OSISM: the manager)
* Ansible is written in python and uses YAML-formatted configuration files

![Ansible hosts](ansible_inv_start.svg)

### Ansible Playbooks
* An *ansible playbook* is a set of *ansible plays*
* An *ansible play* applies *tasks* to the applicable managed nodes (mapped hosts)
* Tasks are often composed of *ansible roles*, which are reusable fragments with
    - tasks (instructions to execute)
    - handlers (a task that gets only executed if triggered by a change)
    - variables (settings that control aspects of the task)
* Ansible playbooks *should* be written such that they are *idempotent*
    - Their job is to bring the managed node into the desired state
    - If it already is in the right state, nothing should be done
    * This is best practice in configuration management and allows to create reconciliation loops
* An *ansible collection* is a format to bundle a set of playbooks, roles, modules and plugins that
    can be used independently

### Ansible demo: Inventory
* We follow the instructions at <https://docs.ansible.com/ansible/latest/getting_started/>

Inventory directory `inventory` content `inventory/hosts` (ini format)
```ini
[group1]
hostname1
IP-address2
# comment

[group2]
hostname3
hostname4
hostname5

[metagroup:children]
group1
group2
```

Test reachability
```bash
ansible -m ping -u ANSIBLEUSER -m ping ROLEORGROUP
```

* Above introduced groups and metagroups
* Inventory files can alternatively be kept in yaml format
* You can set per host variables `host_vars/nodename/vars.yaml`
* Follow <https://docs.ansible.com/ansible/latest/getting_started/get_started_inventory.html>

### Ansible demo: playbooks
`playbooks/testplay.yaml`
```yaml
- name: ping-and-echo-and-touch
  hosts: metagroup
  tasks:
    - name: ping
      ansible.builtin.ping:
       # ignore

    - name: echo
      ansible.builtin.debug:
        msg: hello

    - name: touch
      ansible.builtin.command:
        touch touched
```

Execute it:
```bash
ansible-playbook -i inventory -u ANSIBLEUSER playbook/testplay.yaml
```
* Playbooks <https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html>


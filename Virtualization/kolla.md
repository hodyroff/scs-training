## Containerized OpenStack with kolla-ansible

### Concepts
* All OpenStack services (and the required infrastructure services) are packaged as containers
* These are then deployed to all hosts where they are needed
* Containers are self-contained and can be individually replaced for bug-fixes or upgrades
* Ansible playbooks are used to orchestrate rollout ... of the docker containers

### Kolla-Ansbible
* Is an OpenStack upstream project (with OSISM staff being important core contributors)
* Is well documented <https://docs.openstack.org/kolla-ansible/latest/>

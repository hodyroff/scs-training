## OSISM: Open Source InfraStructure Manager

### What is [OSISM](https://osism.tech/))?
* Lifecycle and deployment management tooling built on top of kolla-ansible
  (and significantly contributing to kolla-ansible)
* Orchestrates the kolla-ansible OpenStack containers plus containers for
    - Infrastructure services (database, queuing, ...)
    - Management tooling (ARA, netbox, phpmyadmin, optional download proxy)
    - Observability tooling (netdata, prometheus)
    - k3s Kubernetes cluster for operator services (add-ons)
    - Optional: Ceph deployment (w/ ceph-ansible or rook)
* OSISM is the reference implementation for the Virtualization (IaaS) layer in
    the SCS project
    - It's used by most SCS compliant production environments (6 plus a few more
      upcoming)
    - Some others use [yaook](https://alasca.cloud/yaook/) or internally grown
      tooling.
* Most of the following information is specific to OSISM (or kolla-ansible),
  though concepts on other tooling is similar.

### Digression: Comparison OSISM and yaook
* yaook also uses containerized OpenStack services
    - Not currently using the kolla ones though, but custom-built
* The service containers are not managed via ansible and docker, but
  orchestrated with Kubernetes (K8s).
* The orchestration is done with K8s operators
    - K8s operators is software that knows how to manage a service, i.e.
      knows how to bring the service up, how to change settings on it,
      how to get it back working in some cases of breakage, how to scale it
      up and down and how to remove it again.
* Deployment thus starts with a (minimal) Bare Metal K8s deployment (yaook-kubernetes)
* yaook has a good abstraction level to reduce complexity for automating OpenStack
  operational tasks
* With maturing yaook operators, this may become the future reference implementation
  for SCS
* Used by a number of production environments (amongst which StackIT, not SCS-compliant,
  and upcoming UhuruTec/Yorizon which will be SCS-compatible).

### The OSISM manager node
* It is the ansible control node of your setup
* Acts as central control point for all changes, the only node where you login during
  normal operations
    - gitops: The configuration settings are stored in git, automation could be built
      to no longer require login to the manager node in order to trigger changes
    - Other nodes are technically accessible (`osism console` command), but this may
      be against policy (except maybe for debugging). Local changes are strongly
      discouraged and potentially destroy the managability/trustworthiness of the
      system.
* Hosts management tooling
    - ARA, netbox, database, phpmyadmin, OpenSearch(optional)
    - CLI tooling for the operator
    - Homer Web Frontend for the operator
* The configuration repository is stored in `/opt/configuration/`
    - Main location for config settings there in `inventory/` and `environments/` directories,
      e.g. `/opt/configuration/environments/kolla/` for the OpenStack services.
        * Rendered OpenStack config files in `/etc/kolla/`, collected logs in `/var/log/kolla/`
* Deployment scripts in `/opt/configuration/scripts/`

### Node type: Control node
* Control nodes host infrastructure and OpenStack API services
    -
    -
* Avoid overloading them

### Node type: Compute node
* Compute nodes host the virtual machines
* To do so, they
* Capacity determined by RAM and CPU cores

### Node type: Network node

### Node type: Storage node



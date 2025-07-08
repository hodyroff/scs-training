# Virtualization Layer: Operating Sovereign Cloud Stack IaaS

## Virtualization Architecture
* [Virtualizing hardware](Hardware-Virt.md)
    * KVM, OVS/OVN, Ceph
* [OpenStack architecture overview](OpenStack-Arch.md)
    * OpenStack Core Services
    * Other standard OpenStack Services
    * Internal Services
    * Optional Services
    * Dashboards: Horizon and Skyline
* [Internal infrastructure](Internal-infra.md)
    * Database, memcache
    * Queuing
* [User Management](User-Mgmt.md)
    * Domains
    * Projects
    * Users and Groups
    * Roles
* [Security architecture](Sec-Arch.md)
* [Practical assignments](Assign-VirtArch.md)
    * Study service catalog
    * Look at role assignments

## kolla-ansible and OSISM, Plan your deployment
* [Containerization with kolla](kolla.md)
* [ansible Basics](ansible.md)
* [Manager node, config repo, vault, gitops](osism.md)
    * OSISM overview and manager node
    * Control nodes
    * Compute nodes
    * Network nodes
    * Storage nodes
<!--* [SW-defined Storage (SDS) with Ceph](Ceph-Intro.md)-->
<!--* [SW-defined Networking (SDN) with OVN/OvS](OVN-Intro.md)-->
* [Planning your hardware](HW-Plan.md)
    * HCI vs. decomposed
    * Optional Seed node
* [Bootstrapping the manager](Install.md)
    * Performing the other installation steps
* [Validating the results](Validation.md)
    * ARA
    * Smoke tests
* [The OSISM tool](OSISM-tool.md)
* [Practical assignments](Assign-OSISM.md)
    * Create a config repository
    * Bootstrap and install manager
    * Study the OSISM tool on the manager

## [Basic ceph knowledge](Ceph-Knowledge.md)
* [Ceph architecture and terminology](Ceph-Intro.md)
    * OSDs, Mon, BlueStore, PGs, Pools, Crush map
    * Replication and Erasure coding
    * Block storage (rbd)
    * ObjectStorage (rgw)
    * Optional: CephFS
* [Ceph dashboard](Ceph-Dashboard.md)
* [Ceph tooling (CLI)](Ceph-CLI.md)
    * Performing changes, tuning
* [Hardware advice](Ceph-Hardware.md)
* [Practical assignments](Assign-Ceph.md)
    * Using the dashboard
    * Taking OSDs out and adding OSDs in
    * Changing weights

## [Basic OSISM administration](OSISM-Admin.md)
* [Managing flavors with the flavor manager](OSISM-Admin.md#openstack-flavor-manager)
* [Managing public images with the image manager](OSISM-Admin.md#image-manager)
* [Managing domains, projects, users, onboarding](OSISM-Admin.md#onboarding-users)
<!-- TODO* Collecting usage data (telemetry)-->
* [Practical assignments](OSISM-Admin.md#assignments-manager)
    * Register public images
    * Onboard a new user (in her own domain)

## [Performance and Compliance monitoring](Perf-Compl-Monitoring.md)
* [Netbox, prometheus, Netdata, OpenSearch](Perf-Compl-Monitoring.md#osism-manager-management-tools)
* [OpenStack Health Monitor](Perf-Compl-Monitoring.md#openstack-health-monitor-oshm)
* [The SCS standards](Perf-Compl-Monitoring.md#scs-standards)
    * Overview and process
    * SCS Compliance testing
* [Practical assignments](Perf-Compl-Monitoring.md#assignments-monitoring-and-compliance)
    * Setting up OSHM
    * Studying OSHM dashboard
    * Running SCS compliance tests

## [Test and Validation environments](Environments.md)
* [Production, Reference and Test Environments](Environments.md#production-reference-and-test-environments)
* [Reference/Development Options](Environments.md#options-for-your-environments)
    * Testbed
    * Cloud-in-a-Box
<!--* Validating changes-->
* [Practical assignments](Environments.md@assignments)
    * Looking at CiaB configuration
    * Look at testbed configuration

## [Maintenance and dealing with errors](Maintenance.md)
* [Database cleanup](Maintenance.md#database-cleanup)
* [Stuck volumes](Maintenance.md#stuck-volumes)
* [Stuck Loadalancers](Maintenance.md#stuck-loadbalancers)
* [Stuck RabbitMQ](Maintenance.md#rabbitmq-issues)
* [Power loss on storage](Maintenance.md@power-loss-on-storage)
* [Troubleshooting Guide](https://docs.scs.community/docs/iaas/guides/troubleshooting-guide/)
* [Practical assignment](Maintenance.md#practical-assignment)
    * Recover from hang volume

## [Updates and Upgrades](Updates.md)
* [Security advisories and security updates](Updates.md#security-updates)
    * Real-world example
* [Rebooting systems](Updates.md#rebooting-systems)
    * Hardware maintenance
    * Hypervisor/Kernel/Firmware updates
    * Live migration/evacuation
* [Version Upgrades](Updates.md#version-upgrades)
* [Adding and removing compute nodes](Updates.md#adding-and-removing-compute-nodes)
* [Practical assignment](Updates.md#practical-assignment)
    * Update a service

## [Supporting users](Support.md)
* [Responsibilities and Data Protection considerations](Support.md#responsibilities-and-data-protection-considerations)
* [Floating IPs](Support.md#floating-ips)
* [Port security and Security groups](Support.md#security-groups)
* [cloud-init](Support.md#cloud-init)
* [Keypairs](Support.md#keypairs)
* [IaC tooling](Support.md#iac-tooling)
* [Using the OpenStack API](Support.md#using-the-openstack-api)
    * `clouds.yaml` examples
* [Stateful vs Stateless VMs](Support.md#stateful-vs-stateless-design)
    * Pets and cattle
* [Scaling](Support.md#scaling)
* [Boot failures](Support.md#troubleshooting-boot-issues-self-support)
    * Console log
    * Storage recovery
* [Backups and snapshots](Support.md#snapshots-and-backups)
* [Security incidents](Support.md#security-incidents-provider-perspective)
    * Fraud
    * Hacked VMs
    * DoS/DDoS
* [Practical assignment](Support.md#practical-assignments-user-perspective)
    * Download a Storage volume
    * Clone a VM
    * Rescue a VM


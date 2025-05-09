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
* [SW-defined Storage (SDS) with Ceph](Ceph-Intro.md)
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

## Basic ceph knowledge
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

## Basic OSISM administration
* [Managing flavors with the flavor manager](Flavor-Manager.md)
* [Managing public images with the image manager](Image-Manager.md)
* [Managing domains, projects, users, onboarding](Onboarding.md)
<!-- TODO* Collecting usage data (telemetry)-->
* [Practical assignments](Assign-Manager.md)
    * Register public images
    * Onboard a new user (in her own domain)

## Performance and Compliance monitoring
* [Netbox, prometheus, Netdata, OpenSearch](Netbox-and-friends.md)
* OpenStack Health Monitor
* The SCS standards: Overview and process
* SCS Compliance testing
* Practical assignments
    * Setting up OSHM
    * Studying OSHM dashboard
    * Running SCS compliance tests

## Test and Validation environments
* Production, Reference and Test Environments
* Reference/Developemtn Options
    * Testbed
    * Cloud-in-a-Box
* Validating changes
* Practical assignments
    * Looking at CiaB configuration
    * Look at testbed configuration

## Dealing with errors
* Database cleanup
* Stuck volumes
* Stuck loadbalancer
* FD leak
* Stuck RabbitMQ
* CiaB: Lost CoW file
* Practical assignment
    * Recover from hang volume

## Updates and Upgrades
* Security advisories and security updates
    * Real-world example
* Regular maintenance updates
* Version Upgrades
* Hardware maintenance
    * Hypervisor/Kernel/Firmware updates
    * Live migration/evacuation
* Adding and removing hardware nodes
* Practical assignment
    * Update a service

## Supporting users
* Data Protection considerations
* Common misunderstandings
    * Floating IPs
    * Keypairs
* cloud-init
* IaC tooling
* Backups and snapshots
* Boot failures
    * Console log
    * Storage recovery
* Port security and Security group performance
* Security incidents
    * Fraud
    * Hacked VMs
    * DoS/DDoS
* Stateful vs Stateless VMs
    * Pets and cattle
* Practical assignment
    * Clone a VM
    * Download a Storage volume


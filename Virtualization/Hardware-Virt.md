## Virtualizing Hardware

* Applications are written to run on servers
* Virtualization:
    - Create an execution environment for the application that looks like a server (landscape)

## Types of virtual hardware
* Compute virtualization:
    - Virtual CPUs, virtual memory (RAM)
* Storage virtualization:
    - Virtual Harddisks (block storage, "volumes")
    - Shared Storage (NFS/CIFS) and Object Storage options
* Network virtualization
    - Virtual Network Cards (Ports)
    - ... connected to virtual networks, routers, ...
    - Virtual firewalls and load-balancers

## Advantages
* Assignment granularity
    - Can assign arbitrary amounts (e.g. 4 CPUs, 16 GiB RAM, 155GB disk),
      independent of actual server sizes
        * Of course real hardware must have sufficient capacity
    - Fractional amounts (shared resources) possible
* Changing assignement on the fly
    - aka vertical scaling
    - Hotplug vs. Coldplug (reboots)
* Additional servers, disks, ... for scalable software
    - horizontal scaling
* Procurement delay (weeks) vs. SW provisioning (seconds/minutes at worst)

## Common technologies
* Compute virtualization
    - VMware ESXi (proprietary)
    - Xen
    - **KVM**
* Storage virtualization
    - SAN (FibreChannel), vSAN
    - NAS (NetApp and friends)
    - **Ceph** (RBD)
* Network virtualization (SDN)
    - VLANs, VxLANs
    - VMware NSX-T
    - Layer3 networks (routed)
    - Cloud: VPC
    - Linux: Bridge
    - OpenvSwitch (OvS) and OVN (Open Virtual Network)

## Infrastructure-as-Code
* Automate the set up of virtual hardware completely
    - Not just single servers, but complete landscapes for complicated 
      application workloads
    - Tooling: Scripts with CLI tools, SDK (e.g. python, go, ...),
      terraform/opentofu, ansible, pulumi, ...
* Automated tests
    - Now include the complete roll-out of the test infrastructure
    - Can be torn down automatically after the test (to limit cost)
    - Load tests
* Keep state at confined places
    - Database
    - Data volume
    - Configuration repository
* Keep everything else stateless
    - Can always be redeployed
        * In case of failure
        * In case of a security breach
        * For an upgrade
    - Typically scales trivially


---
title: SCS Training 1
type: slide
tags: presentation
slideOptions:
  theme: white
  transition: 'slide'
  parallaxBackgroundSize: '1920px 1080px'
  parallaxBackgroundImage: 'https://input.scs.community/uploads/c59eab99-6bac-467b-b72a-30b254cc42dd.png'
---

<style>
    .slides h1 {
        font-size: 40px;
        font-family: lato, "open sans", "sans-serif";
        color: "#50c3a5";
    }
    .slides h2 {
        font-size: 28px;
        font-family: lato, "open sans", "sans-serif";
        color: "#0f5fe1";
    }
    .slides h3 {
        font-size: 24px;
        font-family: lato, "open sans", "sans-serif";
    }
    .slides h4 {
        font-size: 21px;
        font-family: lato, "open sans", "sans-serif";
    }
    .slides li {
        font-size: 18px;
        font-family: lato, "open sans", "sans-serif";
    }
    .slides p {
        font-size: 18px;
        font-family: lato, "open sans", "sans-serif";
    }
    .slides ul {
        display: block!important;
    }
    .slide table {
        font-size: 19px;
        font-family: lato, "open sans", "sans-serif";
    }
    .slide img {
        border: none !important;
    }
    .slide pre {
        font-size: 18px;
    }
</style>

# <font color="#50c3a5" style="text-shadow: -1px 1px 0 #FFF, 1px 1px 0 #FFF, 1px -1px 0 #FFF, -1px -1px 0 #FFF;">Sovereign</font> <font color="#0f5fe1" style="text-shadow: -1px 1px 0 #FFF, 1px 1px 0 #FFF, 1px -1px 0 #FFF, -1px -1px 0 #FFF;">Cloud Stack</font>
## <font color="#7D7D82" style="text-shadow: -1px 1px 0 #FFF, 1px 1px 0 #FFF, 1px -1px 0 #FFF, -1px -1px 0 #FFF;">One platform – standardized, built and operated by many.</font>

## Welcome to the<br/>Advanced SCS Training Course!

---

# SCS Training Overview

* Intro, Recap Fundamentals, Expectations (0.25d)
    * Govstack, Digital Sovereignty, SCS
* Virtualization layer (1.75d)
    * OpenStack, kolla, OSISM
* Container layer (1.75d)
    * Kubernetes, CAPI, SCS Cluster Stacks
* Ops Tooling (0.75d)
    * Monitoring, Registry, Status Page, CI
* Workloads (0.5d)
* Recap 

----

# Your trainers

| Kurt Garloff | Karsten Samaschke |
|-----------|--------------|
| ![Kurt](https://input.scs.community/uploads/e905f4d9-3a67-4b4e-ba20-129833598fb4.jpeg =150x150) | ![Karsten](https://input.scs.community/uploads/f5080f60-46a9-49f7-ba4e-5bcef1ab6f99.png =150x150)
 |
| Open Source Enthusiast 1994- | Open Source Enthusiast 1996- |
| Linux, GCC, OpenStack, Kubernetes | Linux, Kubernetes, CloudNative, AI |
| SUSE, Dt. Telekom, SCS | T-Systems, Entrepreneur |
| CTO of SCS Project | Founder+CTO sustainical |
| CEO [S7n Cloud Services](https://garloff.de/s7n/) | CEO [VanillaCore](https://vanillacore.net/) |

----

## About govstack
* govstack <https://govstack.global/> is an international project to
    - [GovSpecs](https://www.govstack.global/our-offerings/govspecs/): Specify building blocks that support governments to provide digital services to their citizens, businesses, civil society, ...
    - [GovTest](https://www.govstack.global/our-offerings/govtest/): Tests for compliance with GovSpecs
    - [GovLearn](https://www.govstack.global/our-offerings/govlearn/): Learning opportunities around the GovSpec Building Blocks
    - [GovMarket](https://www.govstack.global/our-offerings/govmarket/): Implementations of these specifications
* A number of blocks have been specified, identity management, payment, etc., see <https://govstack.gitbook.io>
    - One of them is a cloud building block
* Govstack is supported by German [BMZ](https://www.bmz.de/en), [GIZ](https://giz.de/), [DIAL](https://dial.global/), [ITU](https://itu.int), [Estonia](https://vm.ee/en)

----

## About Digital Sovereignty
* Sovereignty is the ability to decisions about your fate yourself and be very
  deliberate which dependencies with what risks you are willing to accept.
* Digital platforms tend to come with strong dependencies.
* SCS has [published](https://the-report.cloud/why-digital-sovereignty-is-more-than-mere-legal-compliance/) a four-level taxonomy for digital sovereignty:
    1. Data Sovereignty: The ability to determine where you store your data and
       (independently) with whom you share data and metadata. (EU regulation: GDPR)
    2. Provider Switchability: Freedom of choice between several providers and
       the ability to easily switch between them.
    3. Technical Sovereignty: The ability to study technology, to shape it according
       to your needs, to innovate and to contribute.
    4. Open Operations: The ability to acquire the knowledge and skills from documentation,
       knowledge sharing and learning events, transparency on operational processes in
       order to be capable to operate your own infrastrcuture.

----

## About Sovereign Cloud Stack
* The idea is to leverage mature Open Source Software (OSS) to support digital sovereignty
    - The challenge is to integrate them in a coherent and standardized way to create
      standards and a mature product that can be operated without too much scarce expert knowledge.
* This is done in several ways:
    1. By making it easier for local providers and allow self-hosting, data sovereignty is supported.
    2. By having many provider adhering to the same [technical standards](https://docs.scs.community/standards), switching providers becomes a lot easier. The standards are covered by [automated continuous tests](https://github.com/SovereignCloudStack/standards/Tests/) and can be certified (*SCS-compatible*)
    3. By having an openly developed complete open source [reference implementation](https://docs.scs.community/docs/category/releases), everyone
       can adjust technnology and contribute to it, thus delivering on technical sovereignty (*SCS-open*)
    4. By giving transpareny into operations (e.g. via blog articles, OSHM, Lean Operator Coffee),
       some collaborative element is added to the Ops part of DevOps. [Open Operations](https://openoperations.org/) thus enables the highest level (*SCS-sovereign*).
* SCS was a project by the Open Source Business Alliance e.V. ([OSBA](https://osb-alliance.de/)) in Europe in the [Gaia-X](https://gaia-x.eu/) context and received public funding from German [BMWK](https://bmwk.bund.de/) 2021 -- 2024.
* It has collaboratively and openy developed and reeased 5 versions of *SCS-compatible* IaaS standards,
  1 version of KaaS standards, 8 releases of the reference implementation, has organized two own conferences (SCS summits), 4 Hackathons and has contributed to numerous publications and conferences.
* The standards evolution is now goverend by the Forum SCS-Standards in the non=profit OSBA, whereare open software development continues with the ecosystem partners in the SCS community, governed by the SCS project board.

----

## SCS and govstack
* The SCS project has contributed to the govstack cloud building block, reflecting some high level principles behind the standardization.
* The SCS reference implementation fulfills the govstack Cloud BB's specifications and is thus listed on the GovMarket.
* The trainings are a contribution to spread the skills and this way support Digital Sovereignty. Thanks!

----

## Infrastructure for hands-on work
* What do you have running?
    * Cloud-in-a-Box?
    * Testbeds?
    * Physical setups?
* Trainer-provided
    * 2xCiaB dedicated
    * 2xCiaB in VM on Laptop
    * A few more CiaB in Europe (remote)
    * 1 testbed in Europe (remote)
* Networking to connect to test infra
    * WLAN: GL-AXT1800
    * Password: RXD9H2FTKY

----

## Recap from Cloud Fundamentals training

* What are the advantages of Cloud Computing?
* What is IaC?
* Help with CiaBs needed?
* Questions?

## Expectations

* What do you want to achieve?

## Preparation for this afternoon
* Get wireguard working on your laptop
* We'll distribute configs after the lunch

---

# Virtualization layer

## Virtualizing Hardware

* Applications are written to run on servers
* Virtualization:
    - Create an execution environment for the application that looks like a server (landscape)

----

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

----

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

----

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

----

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


---

## OpenStack Architecture overview

A set of services that manages virtualized resources and gives users interfaces to control these.

![OpenStack Architecture Overview](https://input.scs.community/uploads/78775667-273a-4a37-813d-c31a2bc50a71.svg =800x540)


----

### How is it built?

* API services
    * Independent processes for Compute, Block Storage, Images, Networking, LoadBalancers, Identity, etc.
    * All APIs are RESTful APIs
        * `GET`, `POST`, `PUT`, `PATCH`, `DELETE` verbs for list, create, set, change and delete operations
        * Many APIs are paginated, i.e. `GET` returns only a subset of resources
* Some APIs have background services
    * Conductors, Schedulers, etc.
* Services talk to each other via REST API or via RabbitMQ
* Database keeps tables for the state of resources
    * Tables are each owned by one service
* Identity service has a central role

----

### Keystone: Identity service has a central role
* User authenticates to keystone (typically with some secret) and gets a token
* Token can be validated by individual services
* Tokens have a scope that determines what you can do with them
    * Unscoped
    * Domain scope
    * Project scope 
* Identity service hosts the service catalogue

----

### Keystone: Raw REST API example (against CiaB)
* Discovery (`--cacert ...` needed b/c of self-signed certificate)
```bash
dragon@cumulus(//):~ [4]$ curl -sS -g --cacert "/etc/ssl/certs/ca-certificates.crt" \
    -X GET https://api.in-a-box.cloud:5000/v3 \
    -H "Accept: application/json" | jq .
```   
```json 
{ 
  "version": {
    "id": "v3.14",
    "status": "stable",
    "updated": "2020-04-07T00:00:00Z",
    "links": [
      {
        "rel": "self",
        "href": "https://api.in-a-box.cloud:5000/v3/"
      }
    ],
    "media-types": [
      {
        "base": "application/json",
        "type": "application/vnd.openstack.identity-v3+json"
      }
    ]
  }
}
```
The services are versioned and have versioned (and microversioned) APIs.

----

* Password authentication
```bash
curl -sS --cacert "/etc/ssl/certs/ca-certificates.crt" \
-X POST https://api.in-a-box.cloud:5000/v3/auth/tokens \
-H "Accept: application/json" -H "Content-Type: application/json" -d '
> {
  "auth": {
    "identity": {
      "methods": [
        "password"
      ],
      "password": {
        "user": {
          "name": "test",
          "password": "test",
          "domain": {
            "name": "test"
          }
        }
      }
    }
  },
  "scope": {
    "project": {
      "name": "test"
    }
  }
}
' | jq
``` 

----

```json
{
  "token": {
    "methods": [
      "password"
    ],
    "user": {
      "domain": {
        "id": "b294a22221d54c909557f23b65a53166",
        "name": "test"
      },
      "id": "b4438103db904341b88e0e5f9d9f5540",
      "name": "test",
      "password_expires_at": null
    },
    "audit_ids": [
      "lmk5WwvXR5eBvBx2Dh2z5w"
    ],
    "expires_at": "2025-05-08T14:38:37.000000Z",
    "issued_at": "2025-05-07T14:38:37.000000Z",
    "project": {
      "domain": {
        "id": "b294a22221d54c909557f23b65a53166",
        "name": "test"
      },
      "id": "0ecdbb271d8245f0b458bc1e4526a133",
      "name": "test"
    },
    "is_domain": false,
    "roles": [
      {
        "id": "4095d94d72cb484b85d204d5b5ef913e",
        "name": "reader"
      },
      {
        "id": "72ca54fa55c24fa69c4bdd0803e8014c",
        "name": "member"
      },
      {
        "id": "aaf15f40660a4e58bcd80b661ca30061",
        "name": "load-balancer_member"
      },
      {
        "id": "0c9a55df33a94b55bdcf7bb652b88e22",
        "name": "creator"
      }
    ],
    "catalog": [
      {
        "endpoints": [
          {
            "id": "3b95334448364dab92bd46e75dcab326",
            "interface": "public",
            "region_id": "RegionOne",
            "url": "https://api.in-a-box.cloud:9998",
            "region": "RegionOne"
          },
          {
            "id": "b74a9a69c48b4f44993d6b6cede248c1",
            "interface": "internal",
            "region_id": "RegionOne",
            "url": "https://api.in-a-box.cloud:9998",
            "region": "RegionOne"
          }
        ],
        "id": "037ce0fe8e5246a58f2ca435e321834f",
        "type": "panel",
        "name": "skyline"
      },
[...]
      {
        "endpoints": [
          {
            "id": "737da81d4d7e43e7b2d9ced0dec2ab36",
            "interface": "public",
            "region_id": "RegionOne",
            "url": "https://api.in-a-box.cloud:8780",
            "region": "RegionOne"
          },
          {
            "id": "e49affd2bb0341c5ad30cd4b3bd4bb1a",
            "interface": "internal",
            "region_id": "RegionOne",
            "url": "https://api.in-a-box.cloud:8780",
            "region": "RegionOne"
          }
        ],
        "id": "f7a6b12baa5b46c094a647356c7b54b0",
        "type": "placement",
        "name": "placement"
      }
    ]
  }
}
```

* All services are identified by unique 16byte ids, resources also carry 16 byte uuids (typically in 8-4-4-4-12 notation). 
    - Tools typically support addressing resources by name, but names are *not* enforced to be unique everywhere.

----

* Much easier: Store keystone endpoint and credentials in `~/.config/openstack/clouds.yaml` and `secure.yaml` and
  issue `openstack --os-cloud test catalog list`.

`~/.config/openstack/clouds.yaml`
```yaml
---
clouds:
  test:
    auth:
      username: test
      project_name: test
      auth_url: https://api.in-a-box.cloud:5000/v3
      project_domain_name: test
      user_domain_name: test
    cacert: /etc/ssl/certs/ca-certificates.crt
    identity_api_version: 3
```

`~/.config/openstack/secure.yaml`
```yaml
---
clouds:
  test:
    auth:
      password: test
```

----

### OpenStack Core services
| Type | Name | Function |
|------|------|----------|
| identity | keystone | Identity and Access management |
| network | neutron | Networking (L2+L3) |
| volumev3 | cinder | Block Storage (virtual hard disks) |
| image | glance | Image handling |
| compute | nova | VM management |
| object-store | swift | Object storage (S3-like) -- optional for SCS |

All core services (except Swift) need to be present for SCS-compatible IaaS compliance.
Note on swift: We require an S3 compatible service. (Ideally, both S3 and Swift are offered.)

Note on terminology: OpenStack calls hosts (hardware nodes) hypervisors and VMs instances or servers.

----

### Other standard OpenStack services
| Type | Name | Function and Notes |
|------|------|--------------------|
| orchestration | heat | Deploy sets of resources (like cloudformation, heat-cfn) |
| dns | designate | DNS service |
| load-balancer | octavia | L4 and L7 load balancing |
| key-manager | barbican | Secrets management (e.g. for L7 LB, like vault) |

### Internal OpenStack services
| Type | Name | Function and Notes |
|------|------|--------------------|
| placement | placement | Determine where VMs are started (scheduler), typically only used internally |
| telemetry | ceilometer | Collect usage/metering data (typically not exposed) |

----

### Optional OpenStack services
| Type | Name | Function and Notes |
|------|------|--------------------|
| metric | gnocchi | Aggregation of metering data |
| alarming | aodh | Trigger notifications |
| clustering | senlin | Manage sets of resources |
| sharev2 | manila | Shared filesystems (NFS,CIFS,...) |
| baremetal | ironic | Bare Metal instance management |
| container-infra | magnum | Manage container clusters |

Many more "big tent" services exist (trove - database, zaqar - queuing, mistral - workflow,
sahara - big data, cloudkitty - metering, watcher - optimization), see
<https://www.openstack.org/software/>. They have varying degrees of maturity and
they are not supported by default in the SCS reference implementaton.

----

## OpenStack user managment

### Domains and Projects
* Resources belong to projects (formerly called tenants)
* Projects are structured into domains (optional, mandatory in SCS)
* Domains are thus containers (realms) for
    - Projects
    - Users 
    - Groups
* `Domain_Name:Project_Name`, `Domain_Name:User_Name`, `Domain_Name:Group_Name`
  tuples are unique identifiers. (The corresponding IDs are unique as well, of course.)
* The `domain_manager` role can be handed to customers to manage projects, users and
  groups on their own (self-service)
    - This is secure (they can not grant themselves rights to projects of other domains)
    - This was introduced by SCS community and only merged upstream in OpenStack 2024.2 (SCS R8).
    - The `admin` can however assign rights across domain boundaries if so wanted (not typically
      a good idea)

----

### Role assignments
* Roles are rights (privileges) that users have towards projects
    - For example "User `XYZ@domA` has the right `reader` in project `ABC@domA`.
* Standard roles with increasing level of privilege:
    - Keystone: `reader`, `member`, `manager`, `admin`
    - Most services: `reader`, `member`, `admin`
    - Octavia: `load-balancer_observer`, `load-balancer_member`, `load-balancer_admin`
    - Barbican: `observer`, `creator`, `admin`
* The special cases for Octavia and Barbican are being worked on in the
    secure RBAC cleanup that is currently happening.
* The `service` roles are internal for communication between services.
* These privileges have a scope, e.g. `project` or `domain` or `system`
* Try `openstack --os-cloud=admin role assignment list --names`
* Normal users require `member` (and `creator` for Barbican and `load-balancer_member` for Octavia) roles
  for their own project(s)
    - Resellers or IT managers would have `manager` privilege for their domain(s)
* Role assignment can be indirected via group membership.

----

### Dashboard: Horizon
Horizon is the traditional dashboard that almost every OpenStack cloud offers.
It takes a bit of time to get used to.
![Horizon Screenshot](https://input.scs.community/uploads/43bb600b-42d7-459a-b18c-8919f76f748b.png =800x580)

----

### Dashboard: Skyline
Skyline is a relatively new project and only offered on some clouds.
It has a more modern look and can easily be extended.
![Skyline](https://input.scs.community/uploads/3ed362c1-0d3b-490c-b145-0289627f4adb.png =800x580)

Both dashboards allow to download clouds.yaml or old-style openrc files.

----

## Our Cloud-in-a-Box setup
* Hardware: 8xZen4 cores (16 hyperthreads) Ryzen 7 8845HS, 96GiB RAM (DDR5), 2x4TB NVMe (Lexar NM790), 2x2.5Gbps (Aoostar GEM12)
* CiaB Bare Metal installation
    - Changed to have Ceph use both NVMes
    - Already registered Debian 12 and openSUSE 15.6 image
* SSH (port forwarding) connection possible `ssh -p 8022 dragon@192.168.9.1`
* Connect to it with wireguard
    - Connect to GL-AXT1800 WLAN, `RXD9H2FTKY`
    - Download your individual config at <http://bit.ly/3S3PDMe> and (Linux) put it into `/etc/wireguard/wg0.conf`
    - Linux: `sudo wg-quick up wg0`
    - `ping 192.168.16.10` for testing
* Remember: *Do not use CiaB in production!*


## Look at the dashboards in our test CiaB
* Get your wireguard tunnel up
* Connect to Horizon <https://api.in-a-box.cloud/>
* Connect to Skyline <https://api.in-a-box.cloud:9999/>
* You need to accept the self-signed certificate, sorry!
    - Chrome and other Chromium/Blink based browsers like Edge do not allow that, unfortunately. Firefox works.
* A complete list of Webinterfaces at SCS docs at <https://docs.scs.community/docs/iaas/deployment-examples/cloud-in-a-box/>

----

## Minimum requirements for CiaB
Follow: https://docs.scs.community/docs/iaas/deployment-examples/cloud-in-a-box/

* 32GiB RAM, 4 cores, ~400GiB of storage
    * Physical deployment: It wipes your hard disk!
    * You can do it in a VM

----

## Internal infrastructure

OpenStack requires queuing and a database to work
* We use mariadb (free version of MySQL)
    - Clustered with galera for high availability
* memcached and/or proxysql for caching (performance)
* Queuing connects publishers and consumers of messages
    * which should be processed in order (FIFO)
    * OpenStack traditionally uses [rabbitmq](https://www.rabbitmq.com/docs/queues) as queuing (AMQP) service
    * We learned to prefer Quorum queues where possible

* OSISM comes with significantly more infrastructure
    * Monitoring
    * Lifecycle management
    * Log aggregation and search
    * k3s Cluster (for extensibility)

----

## Security Architecture

### Compute separation
* Hardware virtualization technology separates VMs from each other
    - SCS mandates microcode and hypervisor/kernel mitigations to be active against known CPU vulnerabilities
    - SCS mandates Hyperthreading to be switched off if it's not secure ([scs-0100](https://docs.scs.community/standards/scs-0100-v3-flavor-naming))
* Highest security environments might want to use dedicated hosts or assign dedicated host groups (host aggregates) to avoid sharing hardware with untrusted users.

-----

### Network separation
* User-controlled networks are separated using encapsulation or VxLAN technology
* Internal control traffic is encrypted (https)
* User plane traffic can be encrypted by application operator, optionally using container side-cars or optionally done at the virtualization layer (at the cost of performance)

----

### Storage separation
* ceph enforces storage isolation
* users can use luks for sensitive data
* optional disk encryption, exposed via storage class

----

### Archictecture
* Secrets are stored in ansible vault or external vaults (keepass, hashicorop vault/openbao)
* Internal control traffic encrypted
* Secure delegation of administrative powers with domain-manager role limited to own domain
* CI jobs with security scans
* Constant validation of code (CI) allows quick reaction to vulnerabilities

----

## Assignments Virtualization Architecture
You need have OpenStack client tools installed.
(`pip install openstackclient` or use your Linux distro packages).
Alternatively connect to the CiaB: `ssh -p 8022 dragon@192.168.9.1` and run OpenStack tools there.

### Service catalogue (CiaB)
* Retrieve it using openstack CLI tooling 
alternatively: python SDK)
    - Requires you to have clouds.yaml, secure.yaml
        * (If you connect to the CiaB via ssh, these are already configured)
    - What services do you see?
    - Why are there several endpoints per service?
    - Anything unexpected?
* Get a token from keystone
* List networks (and external networks) for a project

### Domains, projects, roles
* What are domains good for?
* Create a new domain (admin privileges required)
    - Create a domain-manager for it
    - Create a project in it (domain-manager privileges required)
    - Create a user in it
    - Grant her access to the project
* Review all roles (admin privileges)
    - Explain line by line

---

# Welcome to day 2!

## Recap
- Why virtualiation?
- OpenStack services, authentication, user management, dashboards
- Connecting to CiaB
- Questions?

## Outlook for today
- Ansible, Kolla-Ansible, OSISM tooling
- Hardware planning, deployment, validation
- Ceph management intro
- Test and staging environments

## User perspective
- Creating virtual resources
	* Dashboard
	* CLI, SDK
	* terraform, ansible

## Overflow (Fri?)
- Performance and compliance monitoring
- Maintenance and cleanup tasks
- Updates and Upgrades
- User support topics

---

## kolla-ansible and OSISM, Plan your deployment

### Concepts
* All OpenStack services (and the required infrastructure services) are packaged as containers
* These are then deployed to all hosts where they are needed
* Containers are self-contained and can be individually replaced for bug-fixes or upgrades
* Ansible playbooks are used to orchestrate rollout ... of the docker containers

### Kolla-Ansible
* Is an OpenStack upstream project (with OSISM staff being important core contributors)
* Is well documented <https://docs.openstack.org/kolla-ansible/latest/>

----

## Ansible 1x1

### Ansible concepts
* Ansible is a configuration management system that uses ssh to connect to managed nodes (agent-less)
* These are kept track of in an inventory
* Gathered information on those nodes are called facts
* Ansible is run from the control node (in OSISM: the manager)
* Ansible is written in python and uses YAML-formatted configuration files

![Ansible hosts](https://input.scs.community/uploads/41ef51e3-0d9d-457e-a9bb-a39710a91000.svg =400x400)


----

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

----

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

----

Test reachability
```bash
ansible -m ping -u ANSIBLEUSER -m ping ROLEORGROUP
```

* Above introduced groups and metagroups
* Inventory files can alternatively be kept in yaml format
* You can set per host variables `host_vars/nodename/vars.yaml`
* Follow <https://docs.ansible.com/ansible/latest/getting_started/get_started_inventory.html>

----

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

---

## OSISM: Open Source InfraStructure Manager

### What is [OSISM](https://osism.tech/)?
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

----

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

----

### Manager node

* It is the ansible control node of your setup
* Acts as central control point for all changes, the only node where you login during
  normal operations
    - gitops: The configuration settings are stored in git, automation could be built
      to no longer require login to the manager node in order to trigger changes;
      `osism reconciler` prepared for this
    - Other nodes are technically accessible (`osism console` command), but this may
      be against policy (except maybe for debugging). Local changes are strongly
      discouraged and potentially destroy the managability/trustworthiness of the
      system.
* Hosts management tooling
    - ARA, netbox, database, phpmyadmin, OpenSearch(optional)
    - CLI tooling for the operator
    - Homer Web Frontend for the operator, Traefik ("Ingress")
    - Backends for the above: Redis, Postgres
* The configuration repository is stored in `/opt/configuration/`
    - Main location for config settings there in `inventory/` and `environments/` directories,
      e.g. `/opt/configuration/environments/kolla/` for the OpenStack services.
        * Rendered OpenStack config files in `/etc/kolla/`, collected logs in `/var/log/kolla/`
* Deployment scripts in `/opt/configuration/scripts/`

----

### Node type: Control node
* Control nodes host infrastructure and monitoring
    - Database (mariadb/galera cluster, proxysql, memcached)
    - rabbitmq
    - Prometheus
    - Grafana
    - OpenSearch (if not disabled), fluentd
    - k3s (if enabled, useful for extending control plane, e.g. with keycloak)
* OpenStack services
    - keystone
    - cinder, manila (if enabled)
    - glance
    - magnum (if enabled)
    - designate
    - barbican (if enabled), octavia
    - skyline, horizon
    - nova (not compute, libvirt, ssh)
    - aodh (if enabled)
* Avoid overloading them

----

### Node type: Compute node
* Compute nodes host the virtual machines
* To do so, they host a few OpenStack services
    - cinder, iSCSI (tgtd, iscsid)
    - nova (compute, libvirt, ssh)
    - neutron metatdata agent
* Also prometheus, fluentd
* Capacity determined by RAM and CPU cores

### Node type: Network node
* Networking functions
    - neutron
    - octavia
    - openvswitch and OVN

### Node type: Storage node
* Ceph containers
    - OSDs
    - Mon+Mgr, MDS, RGW

---

### Hardware setup plan
See also <https://docs.scs.community/docs/iaas/guides/concept-guide/bom>

### Hyperconverged vs. Fully decomposed
* We need some nodes to run OSISM
    - 1 manager node (M)
    - 3 control plane nodes (M)
    - 3 network nodes (M)
    - 3 ceph storage nodes (S)
    - 3 compute nodes (L), better 4+
        * The 4th compute node helps with doing rolling upgrades for clusters of all kinds
        * E.g. a Cluster-API cluster with 3 anti-affinity control plane nodes needs a 4th compute host          for a rolling upgrade
* A fully decomposed setup would thus have 14+ nodes
* We can combine some functions
    - Combine storage and Compute nodes
    - Combine Control Plane and Network Nodes
    - This results in a setup with 8 nodes
    - This is how the testbed setup looks like (7 nodes actually, only 3 for compute)
* We can go fully hyperconverged (HCI)
    - Then we have 4 large nodes plus one small manager node
    - Reasonable compromise for small systems
    - Some QoS needed to ensure stability in high-load situations
        * Avoid control rabbitmq dropping messages due to customer VM overload
    - More decomposed setups can more easily scale
    - Your security architects may want network nodes to be separate from compute nodes ...

----

### Sizing: Compute Nodes
* Customer VMs have a mixture of 1:2 ... 1:8 ration vCPU to RAM
* vCPUs can be oversubscribed, unlike memory. 2--3x oversubscription per real core is
  a reasonable sizing approach
* Compute nodes thus should have 1:8 ... 1:16 ratios
    - E.g. 64 core w/ 768 GiB RAM, 96 core with 1024 GiB RAM
    - 32 core w/ 384 GiB is perfectly reasonable as well, lower than 16 core w/ 192GiB RAM becomes inefficient
* You could squeeze a bit more by having larger RAM, but you tend to then run against vCPU limits and
  your customers might feel less happy whereas your savings are minimal
* Reserve some cores (1C +5% of all) and some RAM (4GiB + 4% of all) for the host
* Turn on hyperthreading if it's secure on your CPU, it add ~20% CPU power
    - Lower max. oversubscription ratio from 5/Core to 3/Thread then

----

### Sizing: Control Nodes
* Avoid these to hit their limits
    - Especially rabbitmq and also database are needed and must not be starved no resources
* If you run OpenSearch, this alone adds ~32GiB RAM, 4 core requirement (even for smaller clouds)
* Assume 32GiB for small clouds, double for larger ones (plus OpenSearch)
* 16 cores is enough, more for large environments (plus OpenSearch)
* Ensure sufficient and fast storage (database): NVMe (RAID-1)
* k3s also adds 4GiB RAM, 2 cores plus the requirements needed by workloads running on k3s

### Sizing: Network Nodes
* Need to deal with lots of flows
* 16GiB plus 4C for low network utilization
    - double for medium
    - double again for high
* Good network I/O (obviously)

----

### Sizing: Storage Nodes (Ceph):
* 1C (2HTs) and 4GB **per OSD**
    - Double this when using encryption
    - Also add a core and a few GB if you use erasure coding
* Network I/O very important, fast storage obviously
* See notes in Ceph Doc

### Sizing: Manager node:
* 32GB, more if you want to use OpenSearch
* 8C, more for large environments / OpenSearch
* Storage: SSD/NVMe; use 2x1.9TB to have sufficient space for caching packages and containers

### Putting it together:
* Add requirements up when combinig roles in not fully decomposed setups
* Smaller setups will work if you
    - Carefully design QoS settings to avoid starvation
    - You avoid too high load
    - This adds complexity and the engineering time and operational trouble tends to be more
      expensive than the saved hardware cost, at least for production / production-like systems

---

# Installation
### Overview over the steps
* Procure hardware, set it up, connecting them to the network
    - With (static) DHCP this works conveniently
* Bootstrap manager using the Ubuntu autoinstall image
    - BMC allows this without physical USB sticks (but some require SMB or PXE server)
    - Firmware upgrades, NVMe reformatting, ... may conveniently be done now
* On seed node (can be the admin's Linux/Mac/WSL desktop system):
    - Create configuration repository using cookiecutter
    - Setup manager from seed node
* On manager node
    - Configure inventory, select roles (control, compute, cetwork, storage)
    - Customize the setup according to your needs
    - Roll the configuration using the ansible playbooks (via osism CLI)

----

### Bootstrapping hardware (BareMetal provisioning) - Manager and all other reosource nodes
* Autoinstall images are available from OSISM <https://github.com/osism/node-image>
    - Variants based on disk setup (SCSI/SSD sda vs. NVMe nvme0n1)
    - If nothing matches (and you have enough machines to want to avoid manual adjustments)
      you can build your own autoinstall images
* On server hardware, you can attach the boot image as virtual drive
    - Some BMC implementations allow to just upload the images, others require a SMB/CIFS server
    - You can set up a PXE server and have servers do a PXE boot
    - Physically attaching USB stick works as well
* Server needs (outgoing) internet connection to download software and updates
    - If that is unwanted, a package mirror can be set up (see air-gap blog articles)
* Server install phases:
    - Server shuts down after first installation phase, after which (virtual) boot image should be removed
    - Server sets up some services (mostly in docker containers) in the second phase and shuts down again
    - Server is ready after switching it on first the 3rd time 
* You can also manually provision the hardware in case you need to
  <https://docs.scs.community/docs/iaas/guides/deploy-guide/provisioning>

----

### Creating the configuration repository (seed node)
* This should be prepared on the operators control outside of the cloud
    - A desktop system (preferrably Linux, but Mac or WSL work as well) that supports docker
    - A small VM somewhere can be setup if needed; it can be disposed after config repo and manager node are set up
* Follow the steps on <https://docs.scs.community/docs/iaas/guides/deploy-guide/seed>
* Chose where you want to store your configuration repository
    - Any git server will do, your company's git, your private gitlab, a public github will all do
    - Secrets are stored separately
* Install `git python3-pip python3-virtualenv sshpass libssh-dev`
* Run the cookiecutter:
```bash
mkdir cookiecutter-output
docker run \
  -e TARGET_UID="$(id -u)" -e TARGET_GID="$(id -g)" \ 
  -v $(pwd)/cookiecutter-output:/output --rm -it quay.io/osism/cookiecutter
```
* Answer the questions from cookiecutter, see <https://docs.scs.community/docs/iaas/guides/configuration-guide/configuration-repository/#creating-a-new-configuration-repository>
* Output is stored in directory `cookiecutter-output/`. Commit and push it to your git.

----

###  Secrets handling
* There is a subdirectory `cookiecutter-output/secrets/` which is *not* (and should *never* be) commited to git
* Ensure to save the contents of this directory at a safe and secure place!
* `secrets/vaultpass` contains the password for your ansible vault and is stored as a `keepass` file.
    - The *initial* password for the Keepass file is `password`. Change it.
    - Alternatively handle the secrets in another vault of your choice.
* Makefile targets to get ansibale vault secrets, see <https://docs.scs.community/docs/iaas/guides/configuration-guide/configuration-repository/#working-with-encrypted-files>, e.g. `make ansible_vault_show FILE=all`
* Keepass clients exist for many operating systems (incl. Android), there is also a nextcloud app

----

### Inventory
<https://docs.scs.community/docs/iaas/guides/configuration-guide/configuration-repository/#step-4-post-processing-of-the-generated-configuration>
* Cookiecutter creates node `node01` for your manager. Adjust it to the real name.
    - It is convenient to ensure that DNS resolution works with the used names
    - If you use the domain `region1.mycloud.org` and call the manager `manager`, it is
      convenient to have `region1.mycloud.org` as a default search domain and ensure that
      `manager.region1.mycloud.org` resolves to the IP address of the manager node. Same
      for the other nodes.
    - You can use netbox for IP Address Management
    - Set the `ansible_host`
* Set the manager inventory in `environments//manager/hosts`
    - You can set `host_vars` in `environments/manager/host_vars/`
* Gloabl settings: DNS, NTP, .... `environments/configuration.yml`
* Deploy TLS (SSL) certficates in `environments/kolla/certificates/haproxy.pem` and `haproxy-internal.pem`
* Parameter reference: <https://docs.scs.community/docs/iaas/guides/configuration-guide/configuration-repository/#parameter-reference>
* Later (on the manager host in `/opt/configuration/`) : Adjust the inventory
    - List the nodes and add them to the roles `[manager]`, `[monitoring]`, `[control]`,
      `[network]`, `[ceph-control]`, `[ceph-resource]`, `[ceph-rgw:children]` in `inventory/20-roles`.
* You can set `host_vars` there in `inventory/host_vars/NODE.yml`
    - You can also assign vars to group (Group vars), use `generic` for all groups.
* Changes should always be commited and push to git
* `osism apply configuration` gets the latest status from git (overwrites local changes if any)

----

### Manager
* Setting the operator user: <https://docs.scs.community/docs/iaas/guides/deploy-guide/manager#step-1-create-operator-user>
* Also apply network settings, bootstrap and reboot the manager node
* Deploy the manager service and set vault password (it's in your keepass vault if you did not move it elsewhere)
* These steps should work without any errors

### Nodes
* Do the bare metal provisioning as described before
* Make them managed by applying the bootstrap steps <https://docs.scs.community/docs/iaas/guides/deploy-guide/bootstrap>
* All nodes should be reachable (cf. step 6 with `osism apply ping`), resolve any issues prior to proceeding
    - Remember that an ansible ping verifies that ansible can log in via ssh to manage the host
    - This is why the final steps are `osism apply sshconfig` and `osism apply known-hosts`

----

### Network
* If you use VLANs, Link aggregation (802.3ad, also called bonding or trunking), you will need to adjust
  your network settings.
* For Ubuntu hosts (since OSISM 6.1.0), netplan is used,
  read <https://docs.scs.community/docs/iaas/guides/configuration-guide/network>
* If you want to proxy outgoing internet access on the manager node (e.g. for security reasons),
  read <https://docs.scs.community/docs/iaas/guides/configuration-guide/proxy>
* Extra hints for the loadbalancer, e.g. TLS/SSL certificate deployment:
  read <https://docs.scs.community/docs/iaas/guides/configuration-guide/loadbalancer>
    - Note: This is for the loadbalancer(s) in from of the Infra/OpenStack API services, not the
      loadbalancers that cloud users create with the OpenStack octavia service

----

### Nodes: Infrastructure, Network, Logging/Monitoring, Ceph, OpenStack
* <https://docs.scs.community/docs/iaas/guides/deploy-guide/services/>
  covers this well
* Maintain the order: infra, network, logging/mon, kubernetes (optional), ceph, OpenStack
* This can be scripted (and there are scripts e.g. for testbed deployments)
    - If you use your own script, ensure you do *not* ignore errors
    - `set -e` is a must shell scripts
* For Ceph, the deployment with ceph-ansible is still the default, this will change to
  ceph rook in the future. Ensure you have kubernetes/k3 set up

----

### OpenStack tuning
* See <https://docs.scs.community/docs/iaas/guides/configuration-guide/openstack/>
    - E.g. 3x CPU oversubscription assumes that you have HT(SMT) enabled, you might increase to 5x otherwise.
* It also explains the mechanism how config file tepmlating works and how these are rolled out with
  the ansible playbooks (example: OpenSearch)
* The service specific hints mostly link the upstream OpenStack docu
* The Commons and Services chapters have kolla and OSISM specific information

---

# Validation

### Connect to the deployed environment
* The most convenient is to use wireguard to the manager
* This creates a tunnel into the environment, even if it has otherwise no inbound internet access
    - Access to the manager (192.168.16.10 on testbed/CiaB) and the dashboards ()
    - Access to the external Floating IP networking (`192.168.112.0/24` - inbound connections to VMs)
* Config on manager in `/etc/wireguard/wg0.conf`, client config in dragon home directory
* Create additional wg configs and devices if you want to connect from multiple hosts simultaneously
	- Create additional entries into your `wg0.conf` on the server

----

### Visual inspection
* For an overview of dashboards look at CiaB or testbed documentation
  at <https://docs.scs.community/docs/iaas/guides/configuration-guide/openstack/>
* The most important ones are linked from Homer at: <https://homer.services.YOURCLOUDDOMAIN/>, e.g. (CiaB): <https://homer.services.in-a-box.cloud/>
    - Homer should work and link roughly dozen further dashboards
* Check whether Ceph is healthy
    - `ceph healh detail`
    - Dashboard
* OpenStack dashboard works (horizon and/or skyline)
    - You can login to the Default domain with the admin credentials from vault
    - On CiaB, there is also a test domain with a test user with password test

----

### Reviewing install logs
* ARA records the outcome from all playbooks
    - There should not be any failures
* osism logs

----

### Testing
* RefStack is the framework used by (former) OpenStack InterOp Working Group to run the
  InterOp Guideline tests. In general, you can use it to run sets of Tempest tests.
    - Tempest is the test framework and test case collection from OpenStack
* SCS Compliance test
    - Check whether you fulfill the SCS-compatible IaaS tests (currently version 5.1):
        * Check out <https://github.com/SovereignCloudStack/standards> and go to `standards/Tests/`
        * Ensure you can access your cloud via the API / CLI tools and have configured
              `~/.config/openstack/clouds.yaml` and `~/.config/openstack/secure.yaml` for it
            = Test this with openstack command line tools (you need the python SDK installed anyway)
            - It is recommended to run compliance checks with**out** admin privileges
            - In case they ever clean up too much, this won't hit anything but itself
```bash
# This example assumes you want to name the cloud CiaB-Kurt7 and have a cloud "test" defined in clouds/secure.yaml
./scs-compliance-check.py scs-compatible-iaas.yaml --subject=CiaB-Kurt7 -a os_cloud=test
```

----

* OpenStack Health Monitor
    - Will cover this later
    - Running one iteration manually is a good scenario test for the core functionality (Catalog, Router, Networks, Subnets, Floating IPs, Security Groups, Images, BlockStorage, VMs, metadata-service, LoadBalancer) and also checks the availability of a number of other services.
    - You should get a run without any error or timeout -- i.e. no red color.
    - Same comment as for SCS Compliance test: Run this with normal project `member` privileges, not as admin

* Dashboards from existing SCS clouds
<https://docs.scs.community/standards/certification/overview>

---

## The OSISM tool

### osismclient
* All management happens on the manager node
    - Most of it by calling the osism command line tool
    - It's a wrapper to call the `osism` program in the `osismclient` container
        * except for `update manager` and `update docker`
* osism offers command line completion (with `<TAB>`) and help
    - e.g. `osism reconciler --help`
* `osism get versions manager` gives you information on your managed setup
* `osism log container HOST CONTAINER` will retrieve log files for you (`docker logs`)
* `osism manage XXX` is a wrapper for flavor and image manager

----

### OSISM playbooks
* `osism apply PLAYBOOK` runs ansible playbooks with the appropriate settings
    - `osism apply -a stop PLAYBOOK` would typically stop the service referenced by `PLAYBOOK`
    - `osism apply -a upgrade PLAYBOOK` would get the latest version of a service (container) and then
      run the `PLAYBOOK` to start the service referenced by it
* `osism apply` gives you a list of PLAYBOOKS
* Running playbooks to start services that already run is harmless
    - Changed settings will be applied if there are
    - The playbook summary allows you to see whether that is the case (`changed=`)
* `osism get facts/hosts/hostvars/tasks/...` also just wraps ansible

----

### Performing changes workflow
* Perform changes in the checked out configuration repository ON A TEST OR REFERENCE ENVIRONMENT
    - Typically you end up editing some file under `/opt/configuration/environments/`
    - Push the changes (for your test environment) and apply them:
```bash
osism apply configuration   # Pull config from git
osism reconciler sync       # Adjust derived config files
osism apply facts           # Gather/Update ansible facts
```
    - Run the playbooks that consume the new settings: `osism apply PLAYBOOK`
    - If everything works as designed, commit the same changes to the config repository
      of your production environment.
        * Ensure review and approval processes are in place for this; some changes may
          require customer communication or approval from your security team
        * Same procedure: push to repo and use the above osism commands
* Read recommendations how to work with git branches
  <https://docs.scs.community/docs/iaas/guides/configuration-guide/manager#working-with-git-branches>
* Review is good, testing is better
    - Take reviews seriously!
        * Be mindful of hierarchies or cultural habits that e.g. prevent questioning higher ranked people
        * Think a moment about AF447 or Fukushima


---

## Ceph Introduction

### What is ceph?
* Distributed storage system
    - Performance (throughput) scales with the size of the Ceph cluster
    - Robustness by replication (or erasure-coding)
    - Data is stored on OSDs (Object Storage Devices)
    - Avoiding bottleneck by direct communication between client and OSD (CRUSH map)
    - Object and data scrubbing
    - Invented 2009 by Sage Weil (@Inktank, later acquired by RedHat)
* Provides Object Storage (rados gateway aka rgw with S3 and Swift protocol suppport), Block Storage (rados block device, rbd) and file system (cephfs) support.
* Cephx authentication: Kerberos-like tickets can be retrieved via a shared secret and grant time-limited access to clients.
* Proven in enterprise environments for heavy-duty block and object storage needs
    - De facto OSS reference that everyone benchmarks against
* Alternatives:
    - OSS: drbd, glusterfs, ...
    - Commercial: Huawei FusionStorage, PureStorage, Scality, NetApp, vSAN, ...

----

### Ceph terminology
* Read <https://docs.ceph.com/en/latest/architecture/>
* Ceph Monitor cluster (Mons) maintains the *cluster state* (maps)
    - Cluster Map contains `FSID`, list of pools, placement groups, OSDs, crush map
* Ceph Manager povides that administrative interfaces and additional monitoring
    - It runs typically alongside the Mons and is required these days for normal operation
* OSDs keep the data by writing them to local storage and by replicating them to other OSDs
    - Several options exist for local storage, preferred format is bluestore nowadays
    - Can separate data from metadata drives, the latter being more important for performance
    - OSDs are aware of their neighbours and report failures to contact them to mons
* Data is sorted into *pools*
    - Pools can have their individual replication strategy, scrubbing policy etc.
    - A pool has a set of *placement groups* associated with it
* Clients need calculate the placement group of an object via CRUSH algorithm
    - Hashing the object ID resulting in an identifier `<POOLID>.<PG>`
    - From the *placement group*, the *Acting Set* can be determined. The Acting Set 
      is a list of OSDs responsible for this PG.
    - Clients can only issue writes to the *Primary* (first member of the PG) who is
      then responsible to replicate the data to the *Secondaries*.

----

### Ceph replication strategies
* Replication strategy is set by pool
* For high availability `size=3`, `min_size=2` is typically used
    - Each object is written to three OSDs.
    - Data integrity can be ensured as long as two OSDs are accessible (`in` and `up`).
* 3x replication is that standard Ceph strategy
    - It is very robust
    - High performance reads
    - Easy scrubbing
    - Net capacity is only 1/3 of gross capacity
* Alternative is erasure coding ("RAID-6 like")
    - Data is split off into a number of K chunks
    - A few more (M) chunks are calculated
    - These chunks are distributed over K+M OSDs
    - Any set of K chunks is sufficient to calculate the data
    - Somewhat compute intensive (for writing and scrubbing)
    - Net capacity is K/(K+M) of gross capacity, e.g. 3/(3+2) = 60%
    - Considered less proven than 3xreplication

----

### Block storage: Rados Block Device
* Client code that exposes ceph storage as a block device
    - A set of freely addressable blocks
    - Like a disk
* Stores blocks of e.g. 4MB as ceph objects
* Available as linux kernel driver (rbd)
    - Acts like other block devices (e.g. SCSI disks)
* Block size considerations:
    - Writes cause Read-Modify-Write cycles, which becomes worse for larger blocks
      (and requires caching for mitigation)
    - Lots of small blocks cause a huge amount of objects
* RBD integrates nicely with OpenStack cinder
* RBD even used as "ephemeral, local" storage for OpenStack flavors by some providers
    - Pro: Makes live migration work without block migration
    - Con: Local storage does not have the expected performance characteristics

----

### Object storage: Rados Gateway (rgw)
* Expose object storage interface for ceph objects
    - Supports S3 API
        - without necessarily imposing the bucket number and global bucket namespace limitations of AWS
    - Supports Swift API
        - exposing the same objects as via S3 (a Swift Container is an S3 Bucket)
* Popular for CSPs that use Ceph for Block Storage anyway
    - However a secondary storage pool may be desirable anyhow
    - OpenStack Swift is an extremely mature and scalable alternative
        * Arguably, the only software component of OpenStack that was stable when OpenStack launched in 2010
* Uses pools `.rgw.root`, `default.rgw.buckets.index`, `default.rgw.buckets.data`, `default.rgw.control`,
    `default.rgw.log`, and `default.rgw.meta` on a standard OSISM ceph-ansible installation.

----

### File Storage: CephFS
* A layer on top of ceph objects that exposes them as a POSIX-like distributed filesystem
* Starts the MetaData Service Daemon (MDS)
* Stores metadata for the filesystem hierarchy (in pools `cephfs_metadata`) and file data (in pool `cephfs_data`)
* Linux Kernel driver for cephfs exists
* OpenStack Manila driver exists to provide access as shared filesystem
    - Can be used to provide K8s rwx (read-write many) storage
* Conservative storage people consider CephFS as not yet sufficiently proven
    - POSIX filesystems have a surprising amount of complexity due to locking needs to avoid races between
      renames, deletions, writes etc.
    - Cache coherency is a challenge for distributed filesystems (and was not satisfactorily tackled
      on NFS prior to v4.1)

----

### Ceph versions
* There is roughly one new stable release per year (spring), with version number N.2.0
    - Bugfixes (typically backports) result in N.2.X patch releases (4-6 weeks)
    - Bugfixes provided upstream for 2 years
* Rolling (online) updates supported from previous two stable releases
* "Oceanic" release names, with increasing first letters
* Ceph users tend to be conservative and adopt new stable releases late
    - Storage *is* valuable
    - OSISM currently offers Quincy (17.2.x) and Reef (18.2.x)
* See <https://docs.ceph.com/en/latest/releases/#ceph-releases-index>

----

## Ceph Dashboard

### Where?
* The Ceph Dashboard is available at <https://manager.systems.YOURCLOUDDOMAIN:7000/>,
  e.g. on <http://manager.systems.in-a-box.cloud:7000/> on a CiaB system
  (after connecting via the wireguard tunnel).
* All dashboards on a CiaB system are linked from
  <https://docs.scs.community/docs/iaas/deployment-examples/cloud-in-a-box/#webinterfaces>.
  Remember that you will need to import the CA certificate or trust the certificate from
  CiaB interfaces.
* The homer service also links some dashboards.
  Homer is at <https://homer.services.YOURCLOUDDOMAIN/>

----

### Ceph Dashboard: Main page
![Ceph Dashboard Main Page](https://input.scs.community/uploads/18b4596f-7ef8-4664-a9bf-0d880d086652.png =720x480)

* Health Status
* Capacity (gross)
* Activity
* Stats (Inventory)

----

### Ceph Dashboard: OSDs
![Ceph OSD Page](https://input.scs.community/uploads/f206c983-c652-4674-9c6b-73326d1f599b.png =720x480)

* List of OSDs with their status
* Administrative actions (e.g. throwing OSDs out) by checking them and using the Edit button
* Be careful!
* Screenshot taken from a CiaB Ceph (reconfigured for 2 LVs on each of the 2 NVMes)

----

### Ceph Dashboard: Pools
![Ceph Pool List](https://input.scs.community/uploads/b2db4280-53ef-482f-8f98-fb35c9fe8827.png =720x480)
* List taken from CiaB install (number of PGs reduced for less used pools)
* Clients and replication settings displayed
* Note that lists are typically paginated (only show 25 entries per page)

----

### Ceph Dashboard: Images
![Ceph Images List](https://input.scs.community/uploads/c54e5b10-eac0-48f6-a9b4-26b6d898a463.png =800x540)

* A few OS images (names correspond to glance IDs)
* A 10GB volume as child from image (names correspond to cinder IDs)



----

## Ceph Command line tooling

### Command line tools
* Are installed in the `cephclient` container on the manager node
    - Beware of extra `\r` (`^M`) in output from docker (depends on your setup) when creating scripts
* Expose the full functionality (more comprehensive than the dashboard)
* Needed for automation (scripts, playbooks, ...)

----

### Information and stats
* `ceph health`
* `ceph status`
* `ceph -w`     # watch health msgs
* `ceph osd status`
* `ceph osd tree`
* `ceph osd df`
* `ceph osd pool stats`
* `ceph osd pool ls detail`
* `ceph pg stat`
* `ceph pg ls-by-pool volumes` # this takes a while
* `rbd -p images ls`    # List RBD objects in image pool, `-p volumes` is interesting as well

----

### Explore, get and set config options
* `ceph config ls`
* `ceph config get osd.11 bdev_enable_discard`
* `ceph config set osd.11 bdev_enable`  # Do this for all devices if you go for it
* `ceph config set osd.11 bdev_async_discard true`  # Ditto

----

### OSD operations
* Taking an OSD (ID `NN`) out for good
```bash
ceph osd crush reweight osd.NN 0.0
# Wait for rebalancing (check with ceph osd safe-to-destroy NN)
ceph osd out osd.NN
systemctl disable --now ceph-osd@NN
ceph osd purge osd.NN
```
* Do this for all OSDs on a node (use `ceph osd tree` to find out) ...
    - Expect this to take time, rebalancing moves a lot of data
    - Final step can be done with `osism apply ceph-shrink-osd -e ireallymeanit=yes -e osd_to_kill=NN,MM,...`
    - `ceph osd crush remove nodename`

----

* Remove broken disk
```bash
ceph osd out osd.NN
systemctl stop ceph-osd@NN
systemctl disable ceph-osd@NN
```
* See more examples in <https://docs.scs.community/docs/iaas/guides/operations-guide/ceph/>

* Upstream ceph docu: <https://docs.ceph.com/en/reef/rados/operations/>
  (This is for reef, use the version that you have in use.)

----

### Ceph tuning
* See hints at <https://docs.scs.community/docs/iaas/guides/configuration-guide/ceph/>
* Kernel sysctl settings: Typically suitable out of the box in OSISM deployment
* Defaults for PGs are set for a small cluster. Enable autoscaler for pools or increase manually for larger clusters (10+ OSDs)
* There are also hints how to setup WAL and DB if those are not co-located on the same NVMe anyway

---

## Performance and Compliance monitoring

### Purpose
* SCS prescribes a flavor naming scheme in standard [scs-0100](https://docs.scs.community/standards/scs-0100-v3-flavor-naming)
    - Flavor names like `SCS-nV-m` denote a flavor with `n` vCPUs and `m` GiB of RAM, the `V` denotes that
      vCPUs might be oversubscribed (up to 5x, or 3x for a hyperthread), but they need to be secure
      (CPU speculation vulnerabilities mitigated), RAM must be ECC protected and not oversubscribed.
    - `SCS-nC-m-20s` would denote a flavor with `n` dedicated Cores (the `C`) and 20 GiB SSD/NVMe
      (the `s`) root disk.
    - Decoding can be done with a simple web tool <https://flavors.scs.community/>.
    - The scheme allows for many more details (such as hypervisor, cpu generation, GPU, ...)
      to be specified via the name, but these are really only used for special requirements.
    - The scheme also prescribes metadata (`extra_specs`) for discoverability
    - Flavors that do not start with `SCS-` are allowed and don't need to comply
* There is also a set of mandatory flavors that need to be present on each cloud that
  wants to be *SCS-compatible* at the IaaS (virtualization) layer. It is specified in standard
  [scs-0103](https://docs.scs.community/standards/scs-0103-v1-standard-flavors).
    - Note that there is a selection of 13 flavors with 1:2, 1:4 and 1:8 ratio of vCPU to RAM (in GiB),
      with up to 16 vCPUs and up to 32GiB of RAM. Larger flavors are of course allowed.
    - Two flavors `SCS-2V-4-20s` and `SCS-4V-16-100s` have a local SSD/NVMe included and are meant
      for etcd and database usage.
* The SCS compliance checks test for these.
	- The SCS flavor manager allows to create these flavors

----

### Usage
* On the manager node, run `osism manage flavors --help`
```bash
dragon@testbed-manager(test):~/.config/openstack [0]$ osism manage flavors --help
usage: osism manage flavors [-h] [--no-wait] [--cloud CLOUD] [--name {scs,osism,local,url}] [--url URL]
                            [--recommended]

options:
  -h, --help            show this help message and exit
  --no-wait             Do not wait until flavor management has been completed
  --cloud CLOUD
                        Cloud name in clouds.yaml 
  --name {scs,osism,local,url}
                        Name of flavor definitions
  --url URL     Overwrite the default URL where the flavor definitions are available
  --recommended         Also create recommended flavors
```

----

## Image Manager 

### Purpose 
* Cloud providers must allow users to upload their own images (within fair use limits)
* For convenience, we recommend they offer public images that are centrally maintained
    - This saves work to customers by not having to upload standard vanilla upstream images
    - And it avoids the need to repeat this regularly to include the latest bug- and security fixes
    - Customization is then done via *user-data* injected at boot and typically consumed by `cloud-init`
* To make them really useful, users need to know what the policies of these images are
    - SCS has specified mandatory metadata (properties) for images in standard [scs-0102](https://docs.scs.community/standards/scs-0102-v1-image-metadata)
    - The metadata specifies technical settings (`architecture`, `os_version`, `min_disk`, `min_ram`),
      image handling policies (`replace_frequency`), image information (`image_source`, `image_build_date`,
      `image_original_user`), licensing information (only required for commercial OSes).
* The Image Manager helps the cloud operator to register compliant public images and to regularly
  provide updated versions of them.

----

### Usage
* On the manager node, run
```bash
dragon@testbed-manager(test):~ [0]$ osism manage image --help
usage: osism manage image [-h] [--no-wait] [--dry-run] [--hide] [--delete] [--latest] [--cloud CLOUD]
                          [--filter FILTER] [--images IMAGES]

options:
  -h, --help            show this help message and exit
  --no-wait             Do not wait until image management has been completed
  --dry-run             Do not perform any changes
  --hide                Hide images that should be deleted
  --delete              Delete images that should be deleted
  --latest              Only import the latest version for images of type multi
  --cloud CLOUD
                        Cloud name in clouds.yaml
  --filter FILTER
                        Filter images with a regex on their name
  --images IMAGES
                        Path to the directory containing all image files or path to single image file
```

----

### Available images (as of 2025-05)
- Debian 12, Debian 11
- Ubuntu 24.04, Ubuntu 22.04, Ubuntu 22.04 Minimal
- Rocky 9, AlmaLinux 9, CentOS Stream 9
- openSUSE Leap 15.6
- Cirros 0.6.3, Cirros 0.6.2

----

### Example
* Example: Register AlmaLinux 9
```bash 
dragon@testbed-manager(test):~ [0]$ osism manage image --cloud admin --latest --filter "AlmaLinux"`
2025-05-09 16:44:43 | INFO     | It takes a moment until task 27d41583-8bca-4518-a861-81b101fe3cf2 (image-manager) has been started and output is visible here.
2025-05-09 16:44:45 | INFO     | Processing image 'AlmaLinux 9 (20241120)'
2025-05-09 16:44:45 | INFO     | Tested URL https://swift.services.a.regiocloud.tech/swift/v1/AUTH_b182637428444b9aa302bb8d5a5a418c/openstack-images/almalinux-9/20241120-almalinux-9.qcow2: 200
2025-05-09 16:44:45 | INFO     | Importing image AlmaLinux 9 (20241120)
2025-05-09 16:44:45 | INFO     | Importing from URL https://swift.services.a.regiocloud.tech/swift/v1/AUTH_b182637428444b9aa302bb8d5a5a418c/openstack-images/almalinux-9/20241120-almalinux-9.qcow2
2025-05-09 16:44:46 | INFO     | Waiting for image to leave queued state...
2025-05-09 16:44:48 | INFO     | Waiting for import to complete...
2025-05-09 16:44:58 | INFO     | Waiting for import to complete...
[...]
2025-05-09 16:49:10 | INFO     | Waiting for import to complete...
2025-05-09 16:49:20 | INFO     | Import of 'AlmaLinux 9 (20241120)' successfully completed, reloading images
2025-05-09 16:49:20 | INFO     | Checking parameters of 'AlmaLinux 9 (20241120)'
2025-05-09 16:49:20 | INFO     | Setting internal_version = 20241120
2025-05-09 16:49:20 | INFO     | Setting image_original_user = almalinux
2025-05-09 16:49:20 | INFO     | Adding tag os:centos
2025-05-09 16:49:20 | INFO     | Setting property architecture: x86_64
2025-05-09 16:49:21 | INFO     | Setting property hw_disk_bus: scsi
2025-05-09 16:49:21 | INFO     | Setting property hw_rng_model: virtio
2025-05-09 16:49:21 | INFO     | Setting property hw_scsi_model: virtio-scsi
2025-05-09 16:49:21 | INFO     | Setting property hw_watchdog_action: reset
2025-05-09 16:49:21 | INFO     | Setting property hypervisor_type: qemu
2025-05-09 16:49:21 | INFO     | Setting property os_distro: centos
2025-05-09 16:49:21 | INFO     | Setting property os_version: 9
2025-05-09 16:49:21 | INFO     | Setting property replace_frequency: quarterly
2025-05-09 16:49:22 | INFO     | Setting property uuid_validity: last-3
2025-05-09 16:49:22 | INFO     | Setting property provided_until: none
2025-05-09 16:49:22 | INFO     | Setting property image_description: AlmaLinux 9
2025-05-09 16:49:22 | INFO     | Setting property image_name: AlmaLinux 9
2025-05-09 16:49:22 | INFO     | Setting property internal_version: 20241120
2025-05-09 16:49:22 | INFO     | Setting property image_original_user: almalinux
2025-05-09 16:49:22 | INFO     | Setting property image_source: https://repo.almalinux.org/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-latest.x86_64.qcow2
2025-05-09 16:49:23 | INFO     | Setting property image_build_date: 2024-11-20
2025-05-09 16:49:23 | INFO     | Checking status of 'AlmaLinux 9 (20241120)'
2025-05-09 16:49:23 | INFO     | Checking visibility of 'AlmaLinux 9 (20241120)'
2025-05-09 16:49:23 | INFO     | Setting visibility of 'AlmaLinux 9 (20241120)' to 'public'
2025-05-09 16:49:23 | INFO     | Renaming AlmaLinux 9 (20241120) to AlmaLinux 9
```
* Image was converted to raw to allow for Copy-on-Write usage with ceph
    - This took a bit of time (4min30s) on ceph on the testbed's ceph

----

## Onboarding users

### Workflow
* Create a domain
* Create first user in domain
    - For self-service capabilities (recommended): Assign domain-scoped manager role for domain
        * !NOTE! Never ever confuse `admin` privileges with `manager`. An `admin` owns your cloud.
* Create first project in domain, assign project-scoped `member` (+`load-balancer_member` + `creator`) roles
    - Optional convenience: Create first network with subnet, first router, connect to public network and subnet
    - Default security group (with egress and only internal traffic allowed) should nbe automatically there
* Recommendation: Automate these steps
    - Script 
    - Workflow triggered from customer platform

----

## Assignments Manager

### Image registration
- Add a Debian 12 image using the openstack image manager
- Add Ubuntu 24.04

### User onboarding
- Perform the steps using the openstack CLI (optional: python SDK)
    * Domain creation
    * First user in Domain
        - Optional: Give domain-scoped manager privs to user
    * Create first project
    * Assign `member`, `load-balancer_member`, `creator` roles for project to user
    * Optional: Net, subnet, router settings
- Validate that the user can work
    * Assign a password, create clouds and secure.yaml and try to work as user
- Put this in a script, accepting two options to toggle domain-manager and default
  network/subnet/router creation

---

## Environments

### Production, Reference and Test environments
* As a cloud provider you may run one or several cloud environments
    - In a typical multi-region setup, the regions are rather independent from each other,
      except for user management
* Your customers typically expect very reliable cloud services
    - Unavailability is very bad, losing data is worse
* Cloud environments must be changed often
    - E.g. for deploying security fixes, for increasing capacity, for deployung upgrades, etc.
* In order to do changes with confidence, you need to test them
    - Validating that the changes are good
    - Validating that your roll out procedures work reliably
    - Validating that you can roll back in case of trouble
* Testing is typically done in a reference environment (sometimes also called staging or preproduction)
    - A staging environment has the same configuration as your production plus the changes under test
* You may need environments where you can try out wilder things and diverge more. We call them
    test or development environments.

----

### Options for your environments
* You may want your reference environment and especially your development environments to be
  much smaller than production.
    - This is a question of cost
* You may opt to set up the reference with old hardware or make it significantly smaller than
  your production.
* Another option for reference env might be a testbed setup; for development a Cloud-in-a-Box
  might be good enough.

----

#### Testbed
* Testbed is a fully automated multi-node setup where the nodes are VMs rather than physical
  machines. This makes automation *a lot* easier.
    - This makes recreating it straight forward, so you may be better able to always have it working.
    - To be fully automated, a number of the settings are predefined, which might not match
      your production settings and thus prevent it from being a good reference for your
      production.
    - You could adjust this in your fork of the configuration repository or be very careful
      in assessing what test results do well represent your production and which ones do not.
* The default setup for a testbed uses 7 nodes:
    - 1 Manager node (SCS-4V-16-50)
    * 3 Control and Network node (SCS-8V-32-50)
    * 3 Comppute and Storage nodes (SCS-8V-32-50)
    * 3x3 = 9 Volumes (for OSDs) 20GiB each
* Testbed has basic HA properties
* It's not hardened for production and has predefined passwords
* Performance of VMs will suck unless you have enabled nested virtualization
* We use it all the time for our CI testing
* See instructions at <https://docs.scs.community/docs/iaas/deployment-examples/testbed/>

----

#### Cloud-in-a-Box
* Cloud-in-a-Box is a single node deployment of SCS IaaS
    - It can be deployed in a virtual machine (use SCSI disk driver!)
* It has fairly minimal requirements:
    - 32GiB RAM, 4 cores, 400GB disk space, disable k3s and OpenSearch for this small setups
    - A 8 core 96GiB machine with 2 4TB NVMes works really rather well and survices quite some workloads
* Fully automated installation process with very limited adaptability
* Uses self-signed certificates and predefined passwords.
* Do not expose this to the internet! Do not ever put valuable data there.
* Really nice test/development environment
* See instructions at <https://docs.scs.community/docs/iaas/deployment-examples/cloud-in-a-box/>

### Assignments
* Review inventory on a testbed setup

---

# Compliance and performance tests

## Run SCS-compatible compliance checks

## OpenStack Health Monitor

## List of certified clouds

<https://docs.scs.community/standards/certification/overview>

----

### Preview: OSHM dashboard
* Deep-dive: Optional topic for Friday
* Setup instructions: <https://docs.scs.community/standards/certification/overview>

---

## Assignments for Day 2 - OpenStack User

### No 1: Create a VM instance (login to project test@test as user test@test with pwd test)
* Use the dashboard (horizon or skyline) to create a Linux VM
	- Use `SCS-1L-1` flavor
	- There are a few preconditions:
		* Image (Is available, use Debian 12, for example)
		* Public SSH-Key that gets injected via the metadata-service (user-data) into the VM
			* SSH on Windows: putty or WSL with openssh
		* Network (with an IPv4 subnet) that's connected to a router that's connected to the public net
* Access it via ssh
	- You need to assign a floating IP address
	- You need a security group that allows inbound connections to the SSH port
	- Hint: Default user name of Debian Image is `debian` (Ubuntu: `ubuntu`, openSUSE: `linux`)
<br/>


### Advanced 2: Do this with a new network and a new router


### Advanced 3: Do no 1 or even no 2 with openstack CLI (or python SDK)
* Note: `--help` is your friend
* Note2: If you don't have openstackclient locally, you can `ssh -p 8022 dragon@192.168.9.1` (and export OS_CLOUD=test)
<br/>

### Advanced 4: Create a driver VM which runs OpenStack-Health-Monitor

----

## Assignments -- OpenStack Operator

### No 1: Image
* Use OSISM's OpenStack image manager on the manager to to register "Ubuntu 24.04" image

### No 2: Flavor
* Create a flavor `SCS-2V-2-20` (we'll need it for tomorrow)
	* Bonus: Observe the SCS flavor spec (extra_specs)

### No 3: Create a domain for a new customer
* Create a new domain "training-domain" and a project "training-project" in it with a "training-user" in it that has all standard user rights to the project. Create "training-manager" with the domain-manger role. 


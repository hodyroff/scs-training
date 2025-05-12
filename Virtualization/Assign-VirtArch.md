## Assignments Virtualization Architecture

### Service catalogue (CiaB)
* Retrieve it using openstack CLI tooling (alternatively: python SDK)
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

### Digression: Setting up or using a CiaB for testing
<https://docs.scs.community/docs/iaas/deployment-examples/testbed/>
* A Cloud-in-a-Box (CiaB) is an SCS setup for a single node
    - Can be deployed on bare metal (wipes your disk!) or in a VM
* You can collect a lot of experience with it
    - But it's not secure nor highly available, so never even consider
      exposing it to the internet or use for any production purpose
* Moderate resource needs:
    - Minimum 32GiB RAM, 4 cores, 400GiB of disk space (bare metal or VM),
      more is better.
        * For small setups, consider disabling k3s and OpenSearch
    - Recommended: 96GiB+ RAM, 8+ cores, 2x2+TB NVMe
        * Demo System: Aoostar Gem12 w/ Ryzen7 8845HS (8core Zen4), 96GiB
          RAM, 2x4TB Lexar NM790 NVMe, 2x2.5Gbps network -> ~$1500
* Switch it on three times, first time with boot image connected (USB, PXE, BMC)
    - Installation process downloads tens of GB of data, ensure good internet connection
* Create a wireguard tunnel to it
    - This even works from Windows (download and install Wireguard client software)
    - Look at the dashboards listed in the docs page
    - Note that the CiaB uses a self-signed certificate, you need to have your browser
      (and openstack client tooling) trust it.
        * Blink based browsers (Chrome, chromium, edge, ...) don't allow this any longer.

#### Kenya training
* Connect to GL-AXT1800, RXD9H2FTKY
* Get your individual(!) config from <https://docs.scs.community/docs/iaas/deployment-examples/testbed/>
* SSH connection is possible as well: `ssh -p 8022 dragon@192.168.9.1`

## OpenStack Flavor-Manager

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

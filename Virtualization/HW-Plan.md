## Planning hardware

See also <https://docs.scs.community/docs/iaas/guides/concept-guide/bom>

### Hyperconverged vs. Fully decomposed
* We need some nodes to run OSISM
    - 1 manager node (M)
    - 3 control plane nodes (M)
    - 3 network nodes (M)
    - 3 ceph storage nodes (S)
    - 3 compute nodes (L), better 4+
        * The 4th compute node helps with doing rolling upgrades for clusters of all kinds
        * E.g. a Cluster-API cluster with 3 anti-affinity control plane nodes needs a 4th compute host
          for a rolling upgrade
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

### Sizing: Storage nodes
* 1C (2HTs) and 4GB per OSD
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


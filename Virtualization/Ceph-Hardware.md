## Planning hardware for Ceph

### Considerations
* Store one OSD on one device
    - So one server with 4 NVMEs should host 4 OSDs
    - If you can, keep separate (small) boot drives
* All-flash is preferable
    - Then you can just create a bluestore `ceph-volume lvm create --bluestore --data /dev/osd-vgX/osd-X1 --osd-id YX1`
      to have data, WAL and DB on the same device.
      (This example assumed you have created a Volume Group `osd-vgX` on NVMe number `X` (`/dev/nvmeXn1`) on node no `Y`).
    - If you use rotating storage (classical disks), ensure you split out WAL and DB and put those on SSD/NVMe storage.
    - Only consider rotating disks if you want to store a large amounts of object storage data and you can live with
      lower performance. Create a pool with fast sold-state storage for fast volume storage then. (You can have several.)
    - Some flash devices promise better performance when using 4k instead of (default) 512B sectors; you need to reformat
      them if you want to use this (losing all data on them!), see <https://docs.scs.community/docs/iaas/guides/operations-guide/ceph/#check-format-of-a-nvme-device>
* Invest into Enterprise SSD/NVMe
    - 5y @ 3 DWPD rating recommended when exposed as high performance block storage
    - Power Loss Protection allows safe write caching (required by SCS flavor spec for local storage)

### Encryption
* Encryption of data-at-rest is possible by using dm-crypt (LUKS)
    - Costs [some performance](https://scs.community/2023/02/24/impact-of-disk-encryption/)
    - CPU impact not too bad for modern CPUs with hardware AES support
    - You might offer several storage classes, some with and some without encryption, so users can chose between
      performance and highest security requirements
    - Allows easy disposal of broken drives (and avoids worry of stolen drives)
        * It's possible to use self-encrypting device features instead, but that poses operational challenges
          with most BIOSes (which wait for a password to boot, sigh).
    - Example: See testbed config

### Network
* Ensure low-latency, high-bandwidth networking between Ceph OSD nodes
    - Replication and rebalancing can easily saturate two 25GBps links
        * No surprise considering that a single 4x PCIe v4 NVMe has up to 7.5GB/s bandwidth,
          saturating 2x25Gbps network links
    - Put storage traffic on a separate network or do some QoS to avoid ceph starving
      user data and/or control traffic
* Storage nodes obviously need lots of I/O bandwidth
    - Many 4x M.2 PCIe slots for NVMEs (SAS with 12Gbps (or SATA with 6Gbps) is no comparison
      to 4x16Gps of a PCIe4 x4 link, PCIe5 is twice as good, but not yet mainstream)
    - Even SATA-connected SSD devices are still much better than hard disks due to
      twice the bandwidth and two orders of magnitude better seek times / IOPS.
    - 2x25 Gbps (w/ link aggregation) is good, more (4x25Gbps, 2x40Gbps, 2x100Gbps) is beneficial
    - Reserve one full core (2HTs), 4GB RAM per OSD, an additional core for encryption

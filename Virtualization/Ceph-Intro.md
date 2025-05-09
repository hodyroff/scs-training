## Introduction to CEPH

### What is ceph?
* Distributed storage system
    - Performance (throughput) scales with the size of the Ceph cluster
    - Robustness by replication (or erasure-coding)
    - Data is stored on OSDs (Object Storage Devices)
    - Avoiding bottleneck by direct communication between client and OSD (CRUSH map)
    - Object and data scrubbing
    - Invented 2009 by Sage Weil (@Inktank, later acquired by RedHat)
* Provides Object Storage (rados gateway aka rgw with S3 and Swift protocol suppport),
  Block Storage (rados block device, rbd) and file system (cephfs) support.
* Cephx authentication: Kerberos-like tickets can be retrieved via a shared secret and
  grant time-limited access to clients.
* Proven in enterprise environments for heavy-duty block and object storage needs
    - De facto OSS reference that everyone benchmarks against
* Alternatives:
    - OSS: drbd, glusterfs, ...
    - Commercial: Huawei FusionStorage, PureStorage, Scality, NetApp, vSAN, ...

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

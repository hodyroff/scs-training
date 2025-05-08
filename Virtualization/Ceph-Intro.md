## Introduction to CEPH

### What is ceph?
* Distributed storage system
    - Performance (throughput) scales with the size of the Ceph cluster
    - Robustness by replication (or erasure-coding)
    - Data is stored on OSDs (Object Storage Devices)
    - Avoiding bottleneck by direct communication between client and OSD (CRUSH map)
    - Invented 2009 by Sage Weil (@Inktank, later acquired by RedHat)
* Provides Object Storage (rados gateway aka rgw with S3 and Swift protocol suppport),
  Block Storage (rados block device, rbd) and file system (cephfs) support.
* Proven in enterprise environments for heavy-duty block and object storage needs
    - De facto OSS reference that everyone benchmarks against
* Alternatives:
    - OSS: drbd, glusterfs, ...
    - Commercial: Huawei FusionStorage, PureStorage, Scality, NetApp, vSAN, ...



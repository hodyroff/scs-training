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

### Ceph Dashboard: Main page
![Ceph Dashboard Main Page](Screenshot-Ceph1.png)
* Health Status
* Capacity (gross)
* Activity
* Stats (Inventory)

### Ceph Dashboard: OSDs
![Ceph OSD Page](Screenshot-Ceph2.png)
* List of OSDs with their status
* Administrative actions (e.g. throwing OSDs out) by checking them and using the Edit button
* Be careful!
* Screenshot taken from a CiaB Ceph (reconfigured for 2 LVs on each of the 2 NVMes)

### Ceph Dashboard: Pools
![Ceph Pool List](Screenshot-Ceph3.png)
* List taken from CiaB install (number of PGs reduced for less used pools)
* Clients and replication settings displayed
* Note that lists are typically paginated (only show 25 entries per page)

### Ceph Dashboard: Images
![Ceph Images List](Screenshot-Ceph4.png)
* A few OS images (names correspond to glance IDs)
* A 10GB volume as child from image (names correspond to cinder IDs)


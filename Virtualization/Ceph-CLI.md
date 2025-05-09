## Ceph Command line tooling

### Command line tools
* Are installed in the `cephclient` container on the manager node
    - Beware of extra `\r` (`^M`) in output from docker (depends on your setup)
      when creating scripts
* Expose the full functionality (more comprehensive than the dashboard)
* Needed for automation (scripts, playbooks, ...)

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

### Explore, get and set config options
* `ceph config ls`
* `ceph config get osd.11 bdev_enable_discard`
* `ceph config set osd.11 bdev_enable`  # Do this for all devices if you go for it
* `ceph config set osd.11 bdev_async_discard true`  # Ditto

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

* Remove broken disk
```bash
ceph osd out osd.NN
systemctl stop ceph-osd@NN
systemctl disable ceph-osd@NN
```
* See more examples in <https://docs.scs.community/docs/iaas/guides/operations-guide/ceph/>

* Upstream ceph docu: <https://docs.ceph.com/en/reef/rados/operations/>
  (This is for reef, use the version that you have in use.)

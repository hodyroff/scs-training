## Maintenance and Dealing with errors
* There are some maintenance tasks needed for an environment to keep it working well long-term.
* Some errors scenarios exist that need operator attention.

### Database cleanup
* Deleted Servers (VMs) and Volumes are *not* removed from the database tables by OpenStack
    - They are just marked as deleted and deletion time is stored (as was the creation time)
    - You could use those records for billing purposes.
        * This could be a second source of truth (allowing to double-check the records created from ceilometer/gnocchi)
* Once you confirmed you don't need them any longer, you can remove them from the database.
    <!--Add SQL statement here.-->

### Stuck volumes
* Occasionally, you will find cinder volumes that users can not use and not cleanup
    - They could have a `reserved` or `deleting` status for extended amounts of time (many minutes)
    - They could be reported as attached to a VM that has long gone (and which we will only see the UUID of, not the name)
* The cinder service seems to not be cery robust if processing of volume changes fall behind in high (control-plane) load situations
    - Longstanding OpenStack issue ...
* Approach: 
    - Set status to error as admin
        * `openstack --os-cloud=admin volume set --status error UUID`
    - Now you can clean them up
* If this does not work:
    - Check in ceph whether there is an object in the `images` or `volumes` pool that needs deleting
        * Be very careful!
    - If they're not gone yet, you may need to remove from the database as well

### Stuck loadbalancers

## Maintenance and Dealing with errors
* There are some maintenance tasks needed for an environment to keep it working well long-term.
* Some errors scenarios exist that need operator attention.

### Database cleanup

#### Nova

* Deleted Servers (VMs) and Volumes are *not* removed from the database tables by OpenStack
    - They are just marked as deleted and deletion time is stored (as was the creation time)
    - You could use those records for billing purposes.
        * These records could also be a second source of truth (allowing to double-check the records created from ceilometer/gnocchi)
* Once you confirmed you don't need them any longer, you can remove them from the database.
    - As admin, you can ask openstack about deleted servers -- beware, the list may be huge.
        * I have not found a good way to tell `openstack` to sort by deletion time, so you might need to retrieve the complete list and then start by looking at the bottom of the list
```bash
# Getting 100 old deleted servers, the `tr -d` is for CiaB container extra CR
DELETED=$(openstack server list --all --deleted -c ID -f value | tr -d '\r')
```
* Is it recommended to use `nova-manage` to move out old entries to shadow tables (for later deletion)
    - See <https://docs.openstack.org/nova/2024.2/cli/nova-manage.html>

#### Emergency: Delete deleted servers directly in the database (up till Apr 30 23:59:59 UTC)
```sql
USE nova;
DELETE iae FROM `instance_actions_events` AS iae, `instance_actions` AS ia, `instances` AS inst
    WHERE iae.action_id = ia.id AND ia.instance_uuid = inst.uuid 
        AND inst.deleted_at IS NOT null AND inst.deleted_at < "2025-05-01 00:00:00";
DELETE ia FROM `instance_actions` AS ia, `instances` AS inst
    WHERE ia.instance_uuid = inst.uuid 
        AND inst.deleted_at IS NOT null AND inst.deleted_at < "2025-05-01 00:00:00";
DELETE ism FROM `instance_system_metadata` AS ism, `instances` AS inst
    WHERE ism.instance_uuid = inst.uuid 
        AND inst.deleted_at IS NOT null AND inst.deleted_at < "2025-05-01 00:00:00";
DELETE im FROM `instance_metadata` AS im
    WHERE deleted_at IS NOT null and deleted_at < "2025-05-201 00:00:00";
DELETE FROM `block_device_mappings` WHERE deleted_at IS NOT null AND deleted_at < "2025-05-01 00:00:00";
DELETE FROM `instance_info_caches` WHERE deleted_at IS NOT null AND deleted_at < "2025-05-01 00:00:00";
DELETE FROM `instance_extra` WHERE deleted_at IS NOT null AND deleted_at < "2025-05-01 00:00:00";
DELETE FROM `virtual_interfaces` where deleted_at IS NOT null AND deleted_at < "2025-05-01 00:00:00";
DELETE FROM `instances` WHERE deleted_at IS NOT null AND deleted_at < "2025-05-01 00:00:00";
```
Seasoned SQL admins will surely find more efficient ways to do this with joins and the like.
More tables might have foreign key references to the `instances` table, so you might add more `DELETE` statements.



#### Cinder Volumes
* Like Nova, cinder only marks volumes as deleted in the database and records the deletion time, but does
not remove the table entries.
* The openstack CLI does not report them at all, no `--deleted` option.

* It is recommended to use the `cinder-manage` tool
    - See <https://docs.openstack.org/cinder/2024.2/cli/cinder-manage.html>

* Database way (emergency)
```sql
USE cinder;
DELETE FROM `volume_attachment` WHERE deleted = 1 and deleted_at < "2025-05-01 00:00:00";
DELETE FROM `volume_glance_metadata` WHERE deleted = 1 and deleted_at < "2025-05-01 00:00:00";
DELETE FROM `volumes` WHERE deleted = 1 and deleted_at < "2025-05-01 00:00:00";
```
* Similar for snapshots and backups.
* Glance behaves similar, although deleted images do not tend to emerge in huge numbers.

#### Learning
* You need to do regular DB maintenance work with `nova-manage` and `cinder-manage`
    - These can be part of your regular billing runs.


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
* Charging customers for unusable volume may not create enthusiastic responses

### Stuck loadbalancers
* Loadbalancers can get stuck in `PENDING_CREATE` or `PENDING_DELETE`.
    - Stuck means that they remain in this state for more than a minute (and then never make any progress).
    - This happens relatively often with the amphora provider (driver)
    - Fortunatey, the ovn provider does not expose this bad behavior much
* These can not be cleaned up by the user
* There is no CLI command the author is aware of for the admin to set them to error or to delete them
* The solution is to go in the database :-( and set them to error for deletion
* Charging customers for stuck loadbalancers may not create enthusiastic responses
* Loadbalancer: There is a bug that makes the `octavia_api` container leaks file descriptors.
    - See <https://docs.openstack.org/cinder/2024.2/cli/cinder-manage.html>
    - Automated occasional (nightly) restarts of the `octavia_api` container will help to avoid customer impact
        * Alternatively you monitor the FD count or the `octavia_api` availability and restart when the problem approaches / arises

### RabbitMQ issues
* If your rabbitMQ process is starved of resources, it might fail to deliver all messages
* Subscribers can lose connections to rabbitMQ
* The result is that the backend actions are not taken and while the API services may happily accept requests, the requested actions never make any progress
* <!--TODO: How to detect this somewhat reliably-->
* <!--TODO: Recommended mitigation actions-->

### Power loss on storage
* If your complete (ceph) storage subsystem goes down, while virtual machines are running and writing to storage,
  this will result in bad behavior
* This is a typical situation after a power outage, but also happens, when a Cloud-in-a-Box gets shut down
  without stopping all VMs before.
* The result is ugly:
    - Typically the VMs will no longer boot
    - Checking the console log, one can see that their root disks are read-only
    - This is cinder/ceph refusing to let them write
* <!--TODO: Recovery-->

### Practical assignment
* Trainer will create volumes that are attached to already gone VMs or stuck in reserved.
    - Recover
    - Watch out to not lose storage space



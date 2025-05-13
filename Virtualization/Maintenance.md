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

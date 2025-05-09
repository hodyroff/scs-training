## Assignments for Ceph

### Dashboard
* Log in to the dashboard
* Look at Health, OSDs, Pools, RBD images

### Take OSD out and add back in
* Practice this on a non-production system
* Ensure ceph is healthy and has 4 or more OSDs
    - Remember CLI commands?
* Steps:
    - Optional: Change weight to 0, wait for rebalance
    - Mark out, wait for rebalance (if not done before)
    - Stop OSD container (`down`)
* Back in:
    - Start OSD container again (`up`)
    - Mark in
    - Optional: Adjust weights again
    - Watch the rebalancing using dashboard and CLI
* Bonus: Research quick maintenance with `noout` on SCS docu
    - Used for firmware, hypervisor, kernel update
* Bonus: Why would you assign different weights to different OSDs?
    - Perform the commands ...

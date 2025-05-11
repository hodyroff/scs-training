## Validating that the installed environment works

### Connect to the deployed environment
* The most convenient is to use wireguard to the manager
* This creates a tunnel into the environment, even if it has otherwise
  no inbound internet access
    - Access to the manager (192.168.16.10 on testbed/CiaB) and the dashboards ()
    - Access to the external Floating IP networki `` (192.168.112.0/24 - inbound connections to VMs)
* Config on manager in `/etc/wireguard/wg0.conf`, client config in dragon home directory
* Create additional wg configs and devices if you want to connect from multiple hosts simultaneously
    - Change device name (`wg1`), port, virtual server IP 192.168.48.x and virtual client IPs to avoid confusion
    - Obviously, you would want to change the secrets as well in case you want to avoid impersonation of admins

### Visual inspection
* For an overview of dashboards look at CiaB or testbed documentation
  at <https://docs.scs.community/docs/iaas/guides/configuration-guide/openstack/>
* The most important ones are linked from Homer at: <https://homer.services.YOURCLOUDDOMAIN/>
    - Homer should work and link roughly dozen further dashboards
* Check whether Ceph is healthy
    - `ceph healh detail`
    - Dashboard
* OpenStack dashboard works (horizon and/or skyline)
    - You can login to the Default domain with the admin credentials from vault
    - On CiaB, there is also a test domain with a test user with password test

### Reviewing install logs
* ARA records the outcome from all playbooks
    - There should not be any failures
* osism logs

### Testing
* RefStack is the framework used by (former) OpenStack InterOp Working Group to run the
  InterOp Guideline tests. In general, you can use it to run sets of Tempest tests.
    - Tempest is the test framework and test case collection from OpenStack
* SCS Compliance test
    - Check whether you fulfill the SCS-compatible IaaS tests (currently version 5.1):
        * Check out <https://github.com/SovereignCloudStack/standards> and go to `standards/Tests/`
        * Ensure you can access your cloud via the API / CLI tools and have configured
              `~/.config/openstack/clouds.yaml` and `~/.config/openstack/secure.yaml` for it
            = Test this with openstack command line tools (you need the python SDK installed anyway)
            - It is recommended to run compliance checks with**out** admin privileges
            - In case they ever clean up too much, this won't hit anything but itself
```bash
# This example assumes you want to name the cloud CiaB-Kurt7 and have a cloud "test" defined in clouds/secure.yaml
./scs-compliance-check.py scs-compatible-iaas.yaml --subject=CiaB-Kurt7 -a os_cloud=test
```
* OpenStack Health Monitor
    - Will cover this later
    - Running one iteration manually is a good scenario test for the core functionality
      (Catalog, Router, Networks, Subnets, Floating IPs, Security Groups, Images, BlockStorage,
       VMs, metadata-service, LoadBalancer) and also checks the availability of a number
       of other services.
    - You should get a run without any error or timeout -- i.e. no red color.
    - Same comment as for SCS Compliance test: Run this with normal project `member` privileges, not as admin

## OSISM Installation workflow

### Overview over the steps
* Procure hardware, set it up, connecting them to the network
    - With (static) DHCP this works conveniently
* Bootstrap manager using the Ubuntu autoinstall image
    - BMC allows this without physical USB sticks (but some require SMB or PXE server)
    - Firmware upgrades, NVMe reformatting, ... may conveniently be done now
* On seed node (can be the admin's Linux/Mac/WSL desktop system):
    - Create configuration repository using cookiecutter
    - Setup manager from seed node
* On manager node
    - Configure inventory, select roles (control, compute, cetwork, storage)
    - Customize the setup according to your needs
    - Roll the configuration using the ansible playbooks (via osism CLI)

### Bootstrapping hardware (BareMetal provisioning) - Manager and all other reosource nodes
* Autoinstall images are available from OSISM <https://github.com/osism/node-image>
    - Variants based on disk setup (SCSI/SSD sda vs. NVMe nvme0n1)
    - If nothing matches (and you have enough machines to want to avoid manual adjustments)
      you can build your own autoinstall images
* On server hardware, you can attach the boot image as virtual drive
    - Some BMC implementations allow to just upload the images, others require a SMB/CIFS server
    - You can set up a PXE server and have servers do a PXE boot
    - Physically attaching USB stick works as well
* Server needs (outgoing) internet connection to download software and updates
    - If that is unwanted, a package mirror can be set up (see air-gap blog articles)
* Server install phases:
    - Server shuts down after first installation phase, after which (virtual) boot image should be removed
    - Server sets up some services (mostly in docker containers) in the second phase and shuts down again
    - Server is ready after switching it on first the 3rd time
* You can also manually provision the hardware in case you need to
  <https://docs.scs.community/docs/iaas/guides/deploy-guide/provisioning>

### Creating the configuration repository (seed node)
* This should be prepared on the operators control outside of the cloud
    - A desktop system (preferrably Linux, but Mac or WSL work as well) that supports docker
    - A small VM somewhere can be setup if needed; it can be disposed after config repo and manager node are set up
* Follow the steps on <https://docs.scs.community/docs/iaas/guides/deploy-guide/seed>
* Chose where you want to store your configuration repository
    - Any git server will do, your company's git, your private gitlab, a public github will all do
    - Secrets are stored separately
* Install `git python3-pip python3-virtualenv sshpass libssh-dev`
* Run the cookiecutter:
```bash
mkdir cookiecutter-output
docker run \
  -e TARGET_UID="$(id -u)" -e TARGET_GID="$(id -g)" \
  -v $(pwd)/cookiecutter-output:/output --rm -it quay.io/osism/cookiecutter
```
* Answer the questions from cookiecutter, see <https://docs.scs.community/docs/iaas/guides/configuration-guide/configuration-repository/#creating-a-new-configuration-repository>
* Output is stored in directory `cookiecutter-output/`. Commit and push it to your git.

###  Secrets handling
* There is a subdirectory `cookiecutter-output/secrets/` which is *not* (and should *never* be) commited to git
* Ensure to save the contents of this directory at a safe and secure place!
* `secrets/vaultpass` contains the password for your ansible vault and is stored as a `keepass` file.
    - The *initial* password for the Keepass file is `password`. Change it.
    - Alternatively handle the secrets in another vault of your choice.
* Makefile targets to get ansibale vault secrets, see <https://docs.scs.community/docs/iaas/guides/configuration-guide/configuration-repository/#working-with-encrypted-files>, e.g. `make ansible_vault_show FILE=all`
* Keepass clients exist for many operating systems (incl. Android), there is also a nextcloud app

### Inventory
<https://docs.scs.community/docs/iaas/guides/configuration-guide/configuration-repository/#step-4-post-processing-of-the-generated-configuration>
* Cookiecutter creates node `node01` for your manager. Adjust it to the real name.
    - It is convenient to ensure that DNS resolution works with the used names
    - If you use the domain `region1.mycloud.org` and call the manager `manager`, it is
      convenient to have `region1.mycloud.org` as a default search domain and ensure that
      `manager.region1.mycloud.org` resolves to the IP address of the manager node. Same
      for the other nodes.
    - You can use netbox for IP Address Management
    - Set the `ansible_host` 
* Set the manager inventory in `environments//manager/hosts`
    - You can set `host_vars` in `environments/manager/host_vars/`
* Gloabl settings: DNS, NTP, .... `environments/configuration.yml`
* Deploy TLS (SSL) certficates in `environments/kolla/certificates/haproxy.pem` and `haproxy-internal.pem`
* Parameter reference: <https://docs.scs.community/docs/iaas/guides/configuration-guide/configuration-repository/#parameter-reference>
* Later (on the manager host in `/opt/configuration/`) : Adjust the inventory
    - List the nodes and add them to the roles `[manager]`, `[monitoring]`, `[control]`,
      `[network]`, `[ceph-control]`, `[ceph-resource]`, `[ceph-rgw:children]` in `inventory/20-roles`.
* You can set `host_vars` there in `inventory/host_vars/NODE.yml`
    - You can also assign vars to group (Group vars), use `generic` for all groups.
* Changes should always be commited and push to git
* `osism apply configuration` gets the latest status from git (overwrites local changes if any)

### Manager
* Setting the operator user: <https://docs.scs.community/docs/iaas/guides/deploy-guide/manager#step-1-create-operator-user>
* Also apply network settings, bootstrap and reboot the manager node
* Deploy the manager service and set vault password (it's in your keepass vault if you did not move it elsewhere)
* These steps should work without any errors

### Nodes
* Do the bare metal provisioning as described before
* Make them managed by applying the bootstrap steps <https://docs.scs.community/docs/iaas/guides/deploy-guide/bootstrap>
* All nodes should be reachable (cf. step 6 with `osism apply ping`), resolve any issues prior to proceeding
    - Remember that an ansible ping verifies that ansible can log in via ssh to manage the host
    - This is why the final steps are `osism apply sshconfig` and `osism apply known-hosts`

### Network
* If you use VLANs, Link aggregation (802.3ad, also called bonding or trunking), you will need to adjust
  your network settings.
* For Ubuntu hosts (since OSISM 6.1.0), netplan is used,
  read <https://docs.scs.community/docs/iaas/guides/configuration-guide/network>
* If you want to proxy outgoing internet access on the manager node (e.g. for security reasons),
  read <https://docs.scs.community/docs/iaas/guides/configuration-guide/proxy>
* Extra hints for the loadbalancer, e.g. TLS/SSL certificate deployment:
  read <https://docs.scs.community/docs/iaas/guides/configuration-guide/loadbalancer>
    - Note: This is for the loadbalancer(s) in from of the Infra/OpenStack API services, not the
      loadbalancers that cloud users create with the OpenStack octavia service

### Nodes: Infrastructure, Network, Logging/Monitoring, Ceph, OpenStack
* <https://docs.scs.community/docs/iaas/guides/deploy-guide/services/>
  covers this well
* Maintain the order: infra, network, logging/mon, kubernetes (optional), ceph, OpenStack
* This can be scripted (and there are scripts e.g. for testbed deployments)
    - If you use your own script, ensure you do *not* ignore errors
    - `set -e` is a must shell scripts
* For Ceph, the deployment with ceph-ansible is still the default, this will change to
  ceph rook in the future. Ensure you have kubernetes/k3 set up

### OpenStack tuning
* See <https://docs.scs.community/docs/iaas/guides/configuration-guide/openstack/>
    - E.g. 3x CPU oversubscription assumes that you have HT(SMT) enabled, you might increase to 5x otherwise.
* It also explains the mechanism how config file tepmlating works and how these are rolled out with
  the ansible playbooks (example: OpenSearch)
* The service specific hints mostly link the upstream OpenStack docu
* The Commons and Services chapters have kolla and OSISM specific information


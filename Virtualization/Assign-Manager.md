## Assignments Manager

### Image registration
- Add a Debian 12 image using the openstack image manager
- Add Ubuntu 24.04

### User onboarding
- Perform the steps using the openstack CLI (optional: python SDK)
    * Domain creation
    * First user in Domain
        - Optional: Give domain-scoped manager privs to user
    * Create first project
    * Assign `member`, `load-balancer_member`, `creator` roles for project to user
    * Optional: Net, subnet, router settings
- Validate that the user can work
    * Assign a password, create clouds and secure.yaml and try to work as user
- Put this in a script, accepting two options to toggle domain-manager and default
  network/subnet/router creation


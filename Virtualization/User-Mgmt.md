## OpenStack user managment

### Domains and Projects
* Resources belong to projects (formerly called tenants)
* Projects are structured into domains (optional, mandatory in SCS)
* Domains are thus containers (realms) for
    - Projects
    - Users
    - Groups
* `Domain_Name:Project_Name`, `Domain_Name:User_Name`, `Domain_Name:Group_Name`
  tuples are unique identifiers. (The corresponding IDs are unique as well, of course.)
* The `domain_manager` role can be handed to customers to manage projects, users and
  groups on their own (self-service)
    - This is secure (they can not grant themselves rights to projects of other domains)
    - This was introduced by SCS community and only merged upstream in OpenStack 2024.2 (SCS R8).
    - The `admin` can however assign rights across domain boundaries if so wanted (not typically
      a good idea)

### Role assignments
* Roles are rights (privileges) that users have towards projects
    - For example "User `XYZ@domA` has the right `reader` in project `ABC@domA`.
* Standard roles with increasing level of privilege:
    - Keystone: `reader`, `member`, `manager`, `admin`
    - Most services: `reader`, `member`, `admin`
    - Octavia: `load-balancer_observer`, `load-balancer_member`, `load-balancer_admin`
    - Barbican: `observer`, `creator`, `admin` 
* The special cases for Octavia and Barbican are being worked on in the
    secure RBAC cleanup that is currently happening.
* The `service` roles are internal for communication between services.
* These privileges have a scope, e.g. `project` or `domain` or `system`
* Try `openstack --os-cloud=admin role assignment list --names`
* Normal users require `member` (and `creator` for Barbican and `load-balancer_member` for Octavia) roles
  for their own project(s)
    - Resellers or IT managers would have `manager` privilege for their domain(s)
* Role assignment can be indirected via group membership.



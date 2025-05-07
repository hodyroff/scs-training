## Assignments Virtualization Architecture

### Service catalogue (CiaB)
* Retrieve it using openstack CLI tooling (alternatively: python SDK)
    - What services do you see?
    - Why are there several endpoints per service?
    - Anything unexpected?
* Get a token from keystone
* List networks (and external networks) for a project

### Domains, projects, roles
* What are domains good for?
* Create a new domain (admin privileges required)
    - Create a domain-manager for it
    - Create a project in it (domain-manager privileges required)
    - Create a user in it
    - Grant her access to the project
* Review all roles (admin privileges)
    - Explain line by line


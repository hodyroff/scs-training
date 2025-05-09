## Onboarding users

### Workflow
* Create a domain
* Create first user in domain
    - For self-service capabilities (recommended): Assign domain-scoped manager role for domain
* Create first project in domain, assign project-scoped `member` (+`load-balancer_member` + `creator`) roles
    - Optional convenience: Create first network with subnet, first router, connect to public network and subnet
    - Default security group (with egress and only internal traffic allowed) should nbe automatically there
* Recommendation: Automate these steps
    - Script
    - Workflow triggered from customer platform

## Security Architecture

### Compute separation
* Hardware virtualization technology separates VMs from each other
    - SCS mandates microcode and hypervisor/kernel mitigations to be active against known CPU vulnerabilities
    - SCS mandates Hyperthreading to be switched off if it's not secure ([scs-0100](https://docs.scs.community/standards/scs-0100-v3-flavor-naming))
* Highest security environments might want to use dedicated hosts or assign dedicated host groups (host aggregates) to avoid sharing hardware with untrusted users.

### Network separation
* User-controlled networks are separated using encapsulation or VxLAN technology
* Internal control traffic is encrypted (https)
* User plane traffic can be encrypted by application operator, optionally using container side-cars or optionally done at the virtualization layer (at the cost of performance)

### Storage separation
* ceph enforces storage isolation
* users can use luks for sensitive data
* optional disk encryption, exposed via storage class

### Archictecture
* Secrets are stored in ansible vault or external vaults (keepass, hashicorop vault/openbao)
* Internal control traffic encrypted
* Secure delegation of administrative powers with domain-manager role limited to own domain
* CI jobs with security scans
* Constant validation of code (CI) allows quick reaction to vulnerabilities



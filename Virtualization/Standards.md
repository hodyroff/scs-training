## SCS Standards

### Why standards?
* You can easily build cloud and container infrastructure from the same
  technologies that behaves very differently to the users.
    - Even more so if you are using different technologies
* This creates a hard technical lock-in
    - It takes serious effort to automate workloads for the automation
      capabilities of cloud platforms. Using the APIs correctly and
      taking the system behavior into account to create resilient
      deployments is an art that takes a lot of skills, labor and validation.
    - That investment needs to be redone if cloud behave differently
      or have different APIs.
* Very often, the differences add no meaningful customer value, just
  lock-in (= provider value)
* Compete with an large set of highly-compatible small/medium/large
  providers against the huge hyperscalers.
    - It's possible if you ignore the vast majority of platform services
    - These are only useful to a subset of users and result in hard to avoid
      lock-in

### Standardization process
* It's an open collaborative democractic process
    - Governance by SCS project (until 2024) and now Forum SCS-Standards
      in OSBA (non-profit)
* Process defined by stanard SCS-0001 <https://docs.scs.community/standards/scs-0001-v1-sovereign-cloud-standards>
    - Standards have a lifecycle (Draft, Stable, Obsolete) and are versioned
    - A subset of current stabilized standards is chosed to comprise *SCS-compatible IaaS*
      and *SCS-compatible KaaS*. These *certification scopes* are versioned as well.
* Standards come with one or several test cases that can be run manually or automatically
    - We have moved from github actions to a zuul pipeline to run the tests nightly
    - The (curated) results are visible in the compliance monitor
    - Test cases do not need admin privileges, so users can test clouds they have access to
    - In exceptional cases, the certification body (Forum SCS-Standards) may require documentation
      from the provider and can not (fully) test compliance.

### Running tests manually


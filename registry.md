# SCS Container Registry (Harbor)

## Course Overview

This course provides a deep dive into the SCS Container Registry, which is 
based on [Harbor](https://goharbor.io/), an open-source container registry 
solution, CNCF-graduated and widely used in private and hybrid cloud setups. 
We will explore the motivations behind its deployment, understand how it 
operates within the SCS stack, and learn how to manage it in 
production-grade scenarios. Practical, hands-on examples using KinD 
(Kubernetes in Docker) will reinforce key concepts.

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Motivation and Use Cases](#2-motivation-and-use-cases)
3. [SCS Registry Instance Overview](#3-scs-registry-instance-overview)
4. [Testing deployment with KinD](#4-testing-deployment-with-kind)
5. [Rate limiting](#5-rate-limiting)
6. [Backup and Restore](#6-backup-and-restore)
7. [Migration Strategies](#7-migration-strategies)
8. [Persistence](#8-persistence)
9. [High Availability (HA)](#9-high-availability-ha)
10. [Upgrading Harbor](#10-upgrading-harbor)
11. [Summary and Next Steps](#11-summary-and-next-steps)
12. [Appendices and Resources](#12-appendices-and-resources)

---

## 1. Introduction

- Course goals
- Technologies covered: Harbor, KinD, Helm, Kubernetes, FluxCD
- What to expect by the end of this course

---

## 2. Motivation and Use Cases

[ref1](https://docs.scs.community/standards/scs-0218-v1-container-registry-for-scs-standard-implementation/)

Container registry is a service for storing and distributing container images.
It is a repository from which our k8s and OpenStack services can source their
images. Own registry provides full control over images used in our 
deployments - availability, security. Provides versioning, access control,
authentication, vulnerability scanning, signing... 

- Cloud-native - deploys to k8s, HA
- Enterprise-grade features (e.g. RBAC, CVE scanning, replication)
- Replication - beside manual push/pull automatic replication to/from external
  registries
- Observability - natively supports standard observability features - logging,
  metrics, tracing
- Storage of OCI Artifacts – e.g. Helm charts

In order to provide a usable, complete, self-contained experience SCS stack needs 
a registry service in accordance with SCS requirements. Sovereign - not dependent
on external sources.

Keeping images "on-site" and enforcing needed policies. Avoid external services
rate-limiting.

- Private registry - own images
- Proxy registry - mirror external images, avoid rate-limiting, reject 
- Air-gapped registry - security enclaves...

- placement in SCS stack - part of SCS standard
[SCS stack](https://sovereigncloudstack.github.io/website/release/2022/09/21/release3/)

---

## 3. SCS Registry Instance Overview

[Documentation](https://docs.scs.community/docs/category/container-registry)

[ref1](https://github.com/goharbor/harbor/wiki/Architecture-Overview-of-Harbor)

- Description of the Harbor registry deployment
  [diagram](https://github.com/goharbor/website/raw/main/docs/img/architecture/architecture.png)
- 3 layers:
  - data access layer
    - k-v storage (Redis) for caching and jobs metadata
    - data storage - multiple possible backends
    - database (PostgreSQL) - for metadata of Harbor models (projects, users, 
      roles, policies, ...)
  - services
    - proxy (Nginx) for reverse proxy client requests
    - core - core services (API server, various internal managers)
    - job service
    - log collector
    - garbage collection controller
    - chart museum
    ...
  - consumers
- Usage: RestAPI, Web UI
- Security
  - image scanners integration (Trivy)
  - verifying signatures (Cosign)
- Public access and limitations
  - 
- Architecture and components

---

## 4. Testing deployment with KinD

[SCS deployment repository](https://github.com/SovereignCloudStack/k8s-harbor)

- Preparing the environment
  - Prerequisites (KinD, Helm, Docker, kubectl, Flux CLI)

```bash
curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.2.3 bash
flux install
```

- Creating a KinD cluster

```bash 
kind create cluster
```

- Installing Harbor using Helm

```bash
kubectl apply -k envs/dev/
```

- make accessible on localhost

```bash
kubectl port-forward svc/harbor 8080:80
```

- Accessing the Harbor UI and CLI
  - username: admin
  - password: Harbor12345

```bash
http://localhost:8080
```

[Production deployment docs](https://docs.scs.community/docs/container/components/container-registry/docs/scs-deployment)

---

## 5. Rate limiting

- Harbor doesn't yet support rate-limiting out of the box
- use ingress controller in front of Harbor (Nginx)
- specified via annotations

```bash
# means that ingress will allow only 1 request from a given IP per second
$ kubectl edit ingress -n ingress-nginx ingress-nginx-controller
#  metadata:
#    annotations:
#      nginx.ingress.kubernetes.io/limit-rps: "1"
```

- [other ingress annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#rate-limiting)
---

## 6. Backup and Restore

[backup/restore/migration blog](https://sovereigncloudstack.github.io/website/tech/2023/05/30/registry-migration-upgrade/)

- Importance of backups
- Backing up:
  - Harbor database
  - Persistent volumes (registry, charts, etc.)
- automatize process using [Velero](https://velero.io/docs/v1.15/how-velero-works/) - 
  open-source cloud-native backup/restore tool for k8s
- Restore procedures
- Automating backup/restore in CI/CD
- Example backup and restore in KinD

```bash
# deploy single-node single-drive MinIO for S3 bucket as velero backup target
```

```bash
# install velero cli to control the process
wget https://github.com/vmware-tanzu/velero/releases/download/v1.10.2/velero-v1.10.2-linux-amd64.tar.gz 
tar -zxvf velero-v1.10.2-linux-amd64.tar.gz 
sudo mv velero-v1.10.2-linux-amd64/velero /usr/local/bin/
```

```bash
# install velero to cluster
velero install \
    --kubeconfig <path to the kubeconfig file of Cluster_[A,B]> \ 
    --features=EnableAPIGroupVersions \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.6.1 \
    --bucket velero-backup \
    --secret-file ~/.aws/credentials \
    --use-volume-snapshots=false \
    --uploader-type=restic \
    --use-node-agent \
    --backup-location-config <minio target>
```

---

## 7. Migration Strategies

[blog](https://sovereigncloudstack.github.io/website/tech/2023/05/30/registry-migration-upgrade/)

- Reasons for migrating (e.g., environment changes, scaling)
- Migrating from:
  - One Harbor instance to another
  - Docker registry to Harbor
- Tools and scripts
- KinD-based migration lab

---

## 8. Persistence

- Harbor storage needs
  - Images, metadata, configurations
- Using PVCs in KinD
- Configuring external storage (e.g., MinIO, NFS)
- Data integrity checks

---

## 9. High Availability (HA)

- What HA means in the context of Harbor
- Harbor HA architecture (Redis, DB, core, jobservice)
- Setting up HA in a simulated KinD environment
- Load balancing and failover
- Scaling considerations

---

## 10. Upgrading Harbor

- Harbor upgrade strategies
  - always backup before upgrade
  - step-by-step upgrade is necessary because of possible DDL changes in
    Harbor database
  - core executes migration scripts automatically on upgrade, if fail the
    whole helm upgrade process may fail
  - run migrations in pre-update hook - `enableMigrateHelmHook`
- Helm upgrade process
  - backup
  - download new chart
  - configure to the same values as the old one
  - helm upgrade
- Handling downtime and rollback
- Hands-on example with KinD

---

## 11. Summary and Next Steps

- Key takeaways from the course
- Where to go from here
  - Production deployments
  - Advanced automation
  - Monitoring and alerting

---

## 12. Appendices and Resources

- [Harbor documentation](https://goharbor.io/docs/2.1.0/)
- [SCS Container Registry docs](https://docs.scs.community/docs/category/container-registry)
- [SCS Container Registry repo](https://github.com/SovereignCloudStack/k8s-harbor)
- [Harbor upgrade docs](https://goharbor.io/docs/main/administration/upgrade/helm-upgrade/)
- Troubleshooting tips

---

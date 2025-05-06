# SCS Container Registry (Harbor)

## Course Overview

This course provides a deep dive into the SCS Container Registry, which is 
based on [Harbor](https://goharbor.io/), an open-source container registry 
solution, CNCF-graduated and widely used in private and hybrid cloud setups. 
We will explore the motivations behind its deployment, understand how it 
operates within the SCS stack, and learn how to manage it in 
production-grade scenarios. Practical, hands-on examples using [KinD](https://kind.sigs.k8s.io/)
(Kubernetes in Docker) will reinforce key concepts.

## Table of Contents

1. [Introduction](#1-introduction)
2. [Motivation and Use Cases](#2-motivation-and-use-cases)
3. [SCS Registry Instance Overview](#3-scs-registry-instance-overview)
4. [Persistence](#4-persistence)
5. [Rate limiting (optional)](#5-rate-limiting-(optional))
6. [Quickstart Guide](#6-quickstart-guide)
7. [SCS production deployment](#7-scs-production-deployment)
8. [Backup and Restore](#8-backup-and-restore)
9. [Migration](#9-migration)
10. [High Availability (HA)](#10-high-availability-ha)
11. [Upgrading Harbor](#11-upgrading-harbor)
12. [Summary and Next Steps](#12-summary-and-next-steps)
13. [Appendices and Resources](#13-appendices-and-resources)

## 1. Introduction

- Course goals
  - Layout motivation behind including container registry in SCS standard
  - Provide understanding of SCS container registry architecture
  - Explain strategies and scenarios of day-1 (deployment) and day-2 operation
    of the registry
  - Utilize hands-on experience with local example deployments using [KinD](https://kind.sigs.k8s.io/)
- Technologies used 
  - [Harbor](https://goharbor.io/)
  - [KinD](https://kind.sigs.k8s.io/)
  - [Helm](https://helm.sh/)
  - [Kubernetes](https://kubernetes.io/)
  - [FluxCD](https://fluxcd.io/)

## 2. Motivation and Use Cases

[SCS container registry documentation](https://docs.scs.community/docs/category/container-registry)

Container registry is a service for storing and distributing container images.
It is a repository from which our Kubernetes and OpenStack services can source 
their images. Own registry provides full control over images used in our 
deployments - availability, security. Provides versioning, access control,
authentication, vulnerability scanning, signing... 

[SCS maintains standard requirements](https://github.com/SovereignCloudStack/standards/blob/main/Standards/scs-0212-v1-requirements-for-container-registries.md) for such a 
registry implementation contain a list of required and desirable features.

As sumarized in a [SCS decision record](https://github.com/SovereignCloudStack/standards/blob/main/Standards/scs-0218-v1-container-registry-for-scs-standard-implementation.md) Harbor meets these
requirements best as seen in comparison table:

| Features                            | Harbor                                  | Quay                                                                | Dragonfly                     |
|-------------------------------------|-----------------------------------------|---------------------------------------------------------------------|-------------------------------|
| Audit Logs                          | ✓                                       | ✓                                                                   | ✗                             |
| Authentication of system identities | ✓ Robot Accounts                        | ✓ Robot Accounts                                                    | ✗                             |
| Authentication of users             | ✓ Local database, LDAP, OIDC, UAA       | ✓ Local database, LDAP, Keystone, JWT                               | ✓ Local database              |
| Authorization                       | ✓                                       | ✓                                                                   | ✓                             |
| Automation                          | ✓ Webhooks (HTTP, Slack)                | ✓ Webhooks (HTTP, Slack, E-mail ...), building images               | ✗                             |
| Vulnerability scanning              | ✓ Trivy, Clair                          | ✓ Clair                                                             | ✗                             |
| Content Trust and Validation        | ✓ Cosign                                | ✓ Cosign                                                            | ✗                             |
| Multi-tenancy                       | ✓ (not on the storage level)            | ✓ (not on the storage level)                                        | ✓ (not on the storage level)  |
| Backup and restore                  | ✓                                       | ✓                                                                   | ✗                             |
| Monitoring                          | ✓ Prometheus metrics, Tracing           | ✓ Prometheus metrics, Tracing (only for Clair)                      | ✓ Prometheus metrics, Tracing |
| HA mode                             | ✓                                       | ✓                                                                   | ✗                             |
| Registry replication                | ✓                                       | ✓                                                                   | ✓                             |
| Proxy cache                         | ✓                                       | ✓ Feature is in the technology preview stage (non production ready) | ✗                             |
| Quota management                    | ✓ Based on storage consumption          | ✓ Based on storage consumption                                      | ✗                             |
| Garbage collection                  | ✓ Non-blocking                          | ✓ Non-blocking                                                      | ✗                             |
| Retention policy                    | ✓ Multiple tag retention rules          | ✓ Only tag expiration rules                                         | ✗                             |
| Additional supported artifacts      | ✗ (only OCI artifacts)                  | ✗ (only OCI artifacts)                                              | ✓ Maven, YUM                  |
| Integration possibilities           | ✓ Dragonfly (P2P), Kraken (P2P)         | ✗                                                                   | ✓ Harbor, Nydus, eStargz      |
| Deployment capabilities             | ✓ Docker-compose, Helm chart, Operator  | ✓ Docker-compose, Operator                                          | ✓ Docker-compose, Helm chart  |
| Administration capabilities         | ✓ Terraform, CRDs, Client libraries     | ✓ Ansible, Client libraries                                         | ✓ Client libraries            |

In order to provide a usable, complete, self-contained experience SCS stack needs
a registry service in accordance with SCS requirements. Sovereign - not dependent
on external sources.

Keeping images "on-site" and enforcing needed policies. Avoid external services
rate-limiting.

- Use cases
  - Private registry - own images
  - Proxy registry - mirror external images, avoid rate-limiting, reject
    unsuitable images
  - Air-gapped registry - security enclaves...
- Placement in SCS stack - part of SCS standard

![SCS stack](https://sovereigncloudstack.github.io/website/assets/images/201001-SCS-4c-06fe1d5ce5729b4e6bc3ac5190d4dafab09f0374f8e329baeab2b092983a3ea2bc11268e0c783f58f4e991e819375bcf5c6bdc95df977bdea22d145b04f6e934.png)

## 3. SCS Registry Instance Overview

[SCS Documentation](https://docs.scs.community/docs/category/container-registry)

[Architecture overview of Harbor](https://github.com/goharbor/harbor/wiki/Architecture-Overview-of-Harbor)

![Harbor architecture](https://github.com/goharbor/website/raw/main/docs/img/architecture/architecture.png)

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

[SCS container registry](https://registry.scs.community/)

## 4. Persistence

[SCS persistence documentation](https://docs.scs.community/docs/container/components/container-registry/docs/persistence)

Harbor, by design, consists of multiple (micro)services that need to store data.
They can do that variously, based on the Harbor configuration.

- Redis - Key value storage used as a login session cache, a registry manifest 
  cache, and a queue for the jobservice (e.g. Trivy)
  - By default it is deployed as "internal" single node database into the same 
    Kubernetes cluster as Harbor - as a StatefulSet with 1 replica mounting a
    PV (helm value: redis.type.internal)
  - Harbor can be alternatively pointed to a "external" Redis (or Redis Sentinel)
    database (helm value: redis.type.external)
- Database (PostgreSQL) - Stores the related metadata of Harbor models, like 
  projects, users, roles, replication policies, tag retention policies, scanners,
  charts, and images
  - Similarly to Redis, it is by default deployed as a single replica StatefulSet,
    "internal" to the cluster with PV persistence with alternative "external"
    deployment
- OCI distribution registry - for storage of images and charts
  - By default this storage is a PV mounted to `registry` pod
  - Alternatively various other storage backends can be used
- Core services are stateless - do not need storage

## 5. Rate limiting (optional)

[SCS rate limiting documentation](https://docs.scs.community/docs/container/components/container-registry/docs/rate_limit)

- Harbor doesn't yet support rate-limiting out of the box
- Use ingress controller in front of Harbor (Nginx)
- Specified via annotations

```bash
# means that ingress will allow only 1 request from a given IP per second
$ kubectl edit ingress -n ingress-nginx ingress-nginx-controller
#  metadata:
#    annotations:
#      nginx.ingress.kubernetes.io/limit-rps: "1"
```

- [Other ingress annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#rate-limiting)

## 6. Quickstart Guide

- Prepare the environment
  - Install prerequisites (KinD, Helm, Docker, kubectl, Flux CLI)
- Create a KinD cluster

```bash
kind create cluster
```

- Install flux into the cluster

```bash
curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.2.3 bash
flux install
```

- Install Harbor using Helm
  - Clone the [SCS Harbor deployment repository](https://github.com/SovereignCloudStack/k8s-harbor)

  ```bash
  git clone https://github.com/SovereignCloudStack/k8s-harbor.git
  ```

  - Install using provided Kustomize manifest

  ```bash
  kubectl apply -k k8s-harbor/envs/dev/
  ```

- Make accessible on localhost

```bash
kubectl port-forward svc/harbor 8080:80
```

- Accessing the Harbor UI and CLI
  - username: admin
  - password: Harbor12345

```bash
http://localhost:8080
```

### Assignments

1. Install prerequisites for Harbor
2. Create a Kubernetes cluster
3. Using SCS Harbor Helm chart install a registry service into the cluster
4. Setup and verify access
5. Push an image into the registry and verify through UI

## 7. SCS production deployment

[Production deployment docs](https://docs.scs.community/docs/container/components/container-registry/docs/scs-deployment)

[Production SCS container registry](https://registry.scs.community)

- Prerequisites
  - Kubernetes cluster version >=1.20

  ```bash
  export KUBECONFIG=/path/to/kubeconfig
  ```

  - Flux CLI (it is part of SCS KaaS V1)

  ```bash
  # Installation documentation: https://fluxcd.io/flux/installation/#install-the-flux-cli
  curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.2.3 bash
  flux install
  ```

  - kubectl
- Harbor installation

```bash
# Take ingress-nginx-controller LoadBalancer IP address and create DNS record for Harbor.
kubectl get svc -n ingress-nginx
NAME                                 TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)                      AGE
ingress-nginx-controller             LoadBalancer   100.92.14.168   81.163.194.219   80:30799/TCP,443:32482/TCP   2m51s
ingress-nginx-controller-admission   ClusterIP      100.88.40.231   <none>           443/TCP                      2m51s
```

- Secrets generation and installation:

```bash
base/harbor-secrets.bash # pwgen and htpasswd need to be installed
envs/public/s3-credentials.bash <accesskey> <secretkey>
kubectl apply -k envs/public/
```

## 8. Backup and Restore

[SCS Backup and Restore documentation](https://docs.scs.community/docs/container/components/container-registry/docs/backup_and_restore)

- Importance of backups
  - long-term protection of registry data in case of failures, malicious
    activity
  - short-term protection before any potentially damaging operation
- Backing up:
  - Harbor database
  - Persistent volumes (registry, charts, etc.)
- Automatize the process using [Velero](https://velero.io/docs/v1.15/how-velero-works/) -
  open-source cloud-native backup/restore tool for k8s
- Backup strategies
  - Regular backup created using [restic](https://restic.net/) integration
    in Velero - suitable for long-term protection of Harbor data
  - point-in-time snapshot - Velero supports Container Storage Interface
    snapshots - suitable for temporary one-time protection of data before
    some potentially problematic changes, like upgrade
- Prerequisites
  - For snapshot backup
    - Kubernetes version >=1.20
    - appropriate [CSI driver](https://kubernetes-csi.github.io/docs/drivers.html) installed
  - For regular backup
    - Kubernetes version >=1.16
  - S3 compatible backend storage for Velero to store backup data
    - EC2 credentials
- Limitations
  - The key-value database (Redis) storage should not be backed up and/or
    restored, as a result, the user sessions of logged in users that are
    stored in Redis will be lost.
  - The upload purging process can cause backup failures. It is a
    background process of the registry that periodically removes orphaned
    files from the upload directories of the registry. This interval is by
    default set to 24h. Check the timing and perform backup between.

    ```bash
    kubectl --kubeconfig <kubeconfig> logs -l component=registry -c registry --tail -1 | grep -i purge
    ```

- Example backup and restore in KinD
  - Deploy single-node single-drive MinIO for S3 bucket as velero backup target

  ```bash
  mkdir miniodata
  docker run -d \
    --name minio \
    --restart unless-stopped \
    -e MINIO_ROOT_USER="minioroot" \
    -e MINIO_ROOT_PASSWORD="miniorootpass" \
    -v "./miniodata:/data" \
    -p 9000:9000 \
    -p 9001:9001 \
    quay.io/minio/minio:RELEASE.2025-03-12T18-04-18Z \
    server /data --console-address ":9001"
  ```

  - Install MinIO client

  ```bash
  curl -O https://dl.min.io/client/mc/release/linux-amd64/mc
  chmod +x mc
  sudo mv mc /usr/local/bin/
  ```

  - Prepare credentials for velero to use for backup

  ```bash
  mc alias set localminio http://127.0.0.1:9000 miniroot miniorootpass
  mc admin user add localminio velero_user velero_pass123
  ```

  - Add a policy for the velero user

  ```bash
  mc admin policy create localminio velero-policy - <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        "Effect": "Allow",
        "Resource": [
          "arn:aws:s3:::velero",
          "arn:aws:s3:::velero/*"
        ]
      }
    ]
  }
  EOF
  mc admin policy attach localminio velero-policy --user velero_user
  ```

  - Create a bucket

  ```bash
  mc mb localminio/velero
  ```

  - Create a credentials file for velero to use

  ```bash
  cat <<EOF > credentials-velero
  [default]
  aws_access_key_id = velero_user
  aws_secret_access_key = velero_pass123
  EOF
  ```

  - Install velero cli to control the process

  ```bash
  wget https://github.com/vmware-tanzu/velero/releases/download/v1.10.2/velero-v1.10.2-linux-amd64.tar.gz 
  tar -zxvf velero-v1.10.2-linux-amd64.tar.gz 
  sudo mv velero-v1.10.2-linux-amd64/velero /usr/local/bin/
  ```

  - Install velero to cluster

  ```bash
  velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.9.0 \
    --bucket velero \
    --secret-file ./credentials-velero \
    --use-volume-snapshots=false \
    --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://<local IP of host machine>:9000
  ```

  - Create a backup of harbor running in `default` namespace

  ```bash
  velero backup create harbor-backup --include-namespaces default
  ```

  - Simulate the loss of harbor

  ```bash
  kubectl delete -k k8s-harbor/envs/dev/
  ```

  - Restore from `harbor-backup`

  ```bash
  velero restore create --from-backup harbor-backup
  ```

  - In production deployments don't forget to handle PVC snapshots using 
    velero restic integration and CSI plugin for snapshots as described in
    [SCS Backup and Restore documentation](https://docs.scs.community/docs/container/components/container-registry/docs/backup_and_restore)

There is a [case study of backup, migration and upgrade](https://scs.community/tech/2023/05/30/registry-migration-upgrade/)
of [production SCS container registry](https://registry.scs.community/) 
available.

## 9. Migration

[SCS migration documentation](https://docs.scs.community/docs/container/components/container-registry/docs/migration/)

![Migration overview](https://docs.scs.community/assets/images/harbor_migration-15d83bf7e5b37c0bdcb698280dde0684.png)

Our migration scenario uses Velero tool which enables moving one Harbor instance 
as-is from one Kubernetes environment to another Kubernetes environment.
Motivation for migration could be the change of one cloud provider to another, 
moving from an outdated Kubernetes environment, avoiding the Harbor in-place 
upgrade or scaling the cluster.

- Migrating from:
  - One Harbor instance to another
  - Docker registry to Harbor
- Process
  - Using the same tools as in [backup and restore](#8-backup-and-restore)
  - Backup Harbor resources in source cluster to a storage target accessible
    to both clusters
  - Restore the backup to target cluster
- KinD-based migration lab
  - Using existing KinD deployment from [Quickstart guide](#6-quickstart-guide), add a new
    migration target cluster and install velero into it using the process
    described in [Backup and Restore](#8-backup-and-restore). Optionally name
    the target cluster.

  ```bash 
  kind create cluster --name migration-target
  ```

  - By installing velero there with access to the same
    storage target, velero should already see existing backup

  ```bash
  velero backup get
  ```

  - Restore the backup saved in [Backup and Restore](#8-backup-and-restore)
    in the target cluster

  ```bash
  velero restore create --from-backup harbor-backup
  ```

### Assignments

1. Using the process from [Quickstart guide assignments](#6-quickstart-guide)
   create a second Kubernetes cluster
2. Setup a S3 compatible MinIO backup target reachable from both clusters
3. Backup the original Harbor instance using velero
4. Restore the backup into the newly created cluster
5. Verify new instance functionality and the image presence

## 10. High Availability (HA)

[SCS HA documentation](https://docs.scs.community/docs/container/components/container-registry/docs/ha-deployment)

- Minimize Downtime
  - HA ensures that if one component fails, others can continue to serve requests
  - This is crucial for CI/CD pipelines, Kubernetes deployments, or runtime
    environments that pull images continuously
- Scalability and Load Distribution
  - HA setups allow to scale Harbor horizontally, distributing load across
    multiple instances of the API, jobservice, or registry components
- This leads to faster response times and a more resilient service under heavy 
  usage (e.g., during large image pushes or massive cluster rollouts)
- Harbor HA architecture
  - Core Services
    - Core is stateless and can be scaled horizontally, handles the REST API, 
      user management, and the UI backend
    - Multiple replicas can be fronted by a load balancer
  - Jobservice
    - Used for async background tasks: garbage collection, replication, scanning
    - Using Redis
  - Redis
    - Central to HA operation: message queues, cache, job tracking
    - Should be deployed with Redis Sentinel or a clustered Redis setup
  - Registry
    - Docker image registry component
    - Stateless, but relies on shared storage for image layers
    - Needs a persistent volume that’s accessible to all replicas (e.g., NFS, S3)
  - Database (PostgreSQL)
    - Stores all metadata (projects, users, settings, etc.)
    - Must be deployed in HA mode
  - Load Balancer
    - Routes traffic to the core, portal, jobservice, and registry components
    - Can be a simple NGINX ingress or external L4/L7 load balancer
- Trying out HA deployment in KinD
  - Create a multinode KinD cluster

  ```bash
  cat <<EOF > kind-multinode.yaml
  kind: Cluster
  apiVersion: kind.x-k8s.io/v1alpha4
  nodes:
    - role: control-plane
    - role: worker
    - role: worker
    - role: worker
  EOF
  kind create cluster --name ha-test-cluster --config ./kind-multinode.yaml
  ```

  - Install flux

  ```bash
  flux install
  ```

  - Deploy needed operators for certificates, ingress, postgres and redis

  ```bash
  kubectl apply -k k8s-harbor/operators/
  ```

  - Create redis and postgres clusters

  ```bash
  ./k8s-harbor/envs/public-ha/redis/redis-secret.bash # pwgen needs to be installed
  kubectl apply -k k8s-harbor/envs/public-ha/redis/
  kubectl apply -k k8s-harbor/envs/public-ha/postgres/
  ```

  - Get ports on local host on which ingress is accessible

  ```bash
  kubectl get svc -n ingress-nginx
  NAME                                 TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
  ingress-nginx-controller             LoadBalancer   10.96.34.168   <pending>     80:32634/TCP,443:30689/TCP   123m
  ingress-nginx-controller-admission   ClusterIP      10.96.130.44   <none>        443/TCP                      123m

  curl http://localhost:32634
  ```

  - Generate secrets and install

  ```bash
  ./k8s-harbor/base/harbor-secrets.bash # pwgen and htpasswd need to be installed
  ./k8s-harbor/envs/public-ha/swift-secret.bash <username> <password>
  kubectl apply -k k8s-harbor/envs/public-ha/
  ```

  - Simulate node down

  ```bash
  docker pause <container_id>
  ```

### Assignments

1. Create a HA deployment of Harbor registry
2. Verify functionality and access
3. Push an image into registry
4. Simulate one of the nodes down and verify accessibility

## 11. Upgrading Harbor

[SCS upgrade documentation](https://docs.scs.community/docs/container/components/container-registry/docs/upgrade/)

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
  - Backup
  - Download latest version of harbor helm chart

  ```bash
  helm repo add harbor https://helm.goharbor.io
  helm fetch harbor/harbor --untar
  ```

  - Modify values.yaml to actual deployment values
  - Install the newer version under a name

  ```bash
  helm install release_1 harbor/
  ```

### Assignments

1. Upgrade one of the instances created in previous assignments to newes Harbor version
2. Verify functionality, access and image presence

## 12. Summary and Next Steps

- Key takeaways from the course
  - What a Registry Is - a service for storing, versioning, and distributing
    container images
  - Why Harbor? - Harbor best fulfils the SCS requirements for a container
    registry
  - The Role of the Registry in SCS
    - Central to the Sovereign Cloud Stack (SCS) ecosystem, ensures secure,
      verifiable and decentralized image distribution
  - [Public SCS Instance](https://registry.scs.community/) - Hosts public SCS
    images and enables collaboration across the community
  - Hands-on experience with day-1 and day-2 operations of container 
    registry
- Where to go from here
  - [Production deployment](https://docs.scs.community/docs/container/components/container-registry/docs/scs-deployment)
  - Advanced automation
  - [Monitoring and alerting](./monitoring.md)

## 13. Appendices and Resources

- [Harbor documentation](https://goharbor.io/docs/2.1.0/)
- [SCS Container Registry docs](https://docs.scs.community/docs/category/container-registry)
- [SCS Container Registry repo](https://github.com/SovereignCloudStack/k8s-harbor)
- [Harbor upgrade docs](https://goharbor.io/docs/main/administration/upgrade/helm-upgrade/)


# SCS Cluster Stacks Course

## Course Overview

This course explores the concept of [Cluster Stacks](https://docs.scs.community/docs/container/components/cluster-stacks/components/cluster-stacks/overview) within the
[Sovereign Cloud Stack (SCS)](https://www.sovereigncloudstack.org/) ecosystem.
We'll break down their architecture, explain how they standardize Kubernetes
cluster lifecycles, and dive deep into their deployment, configuration, and
evolution. Hands-on examples will guide learners through practical examples
of common scenarios using local [KinD](https://kind.sigs.k8s.io/) clusters.

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [What Are Cluster Stacks?](#2-what-are-cluster-stacks)
3. [Cluster Stacks in the SCS Ecosystem](#3-cluster-stacks-in-the-scs-ecosystem)
4. [Architecture Overview](#4-architecture-overview)
5. [Components and Responsibilities](#5-components-and-responsibilities)
6. [Quickstart Guide](#6-quickstart-guide)
7. [Configuration and Customization](#7-configuration-and-customization)
8. [Upgrading Cluster Stacks](#8-upgrading-cluster-stacks)
9. [Debugging and Observability](#9-debugging-and-observability)
10. [Cluster Stack Use Cases](#10-cluster-stack-use-cases)
11. [Summary and Further Learning](#11-summary-and-further-learning)
12. [Appendices and Resources](#12-appendices-and-resources)

---

## 1. Introduction

- Course objectives
  - Explain the motivation behind another layer of abstraction on top
    of Kubernetes clusters themselves
  - Describe the role of Cluster Stacks in the SCS ecosystem and what
    problems are they solving
  - Provide hands-on examples using local KinD clusters to better accommodate
    learners with the abstract concepts used
- Technologies used
  - [Kubernetes in Docker (KinD)](https://kind.sigs.k8s.io/)
  - [Cluster API](https://cluster-api.sigs.k8s.io/)
  - [Helm](https://helm.sh/)

---

## 2. What Are Cluster Stacks?

Cluster Stacks is a composable, modular, and declarative framework or set of
tooling for defining, provisioning, and managing Kubernetes clusters,
often across cloud providers or infrastructure environments. The term is
inspired by the idea of application stacks, but at the infrastructure layer:
instead of just defining applications that run on Kubernetes, a cluster stack 
defines the actual Kubernetes cluster itself, its configuration, underlying 
infrastructure, and operational policies.

Managing Kubernetes clusters at scale, especially in multi-environment,
multi-cloud, or hybrid-cloud setups, can be error-prone, repetitive, and
inconsistent when done manually or with loosely connected tools. Kubernetes
project [Cluster API (CAPI)](https://cluster-api.sigs.k8s.io/) provides
tooling to simplify provisioning, upgrading, and operating multiple Kubernetes
clusters. While Kubernetes itself provides a way to declaratively define how to
manage application workloads and resources using a cluster paradigm, CAPI
tools allow to define the operation of the cluster itself in similar manner.

- Ensure consistency across dev/staging/prod environments
- Enable GitOps and Infrastructure as Code (IaC) workflows
- Support multi-cluster, multi-cloud strategies
- Reduce operational overhead and human error

CAPI provides these benefits using "managing Kubernetes with Kubernetes"
paradigm, using a bootstrap/management Kubernetes cluster in which controllers
managing target workload cluster run reconciling the target cluster to the
desired state defined declaratively as custom resources.

Cluster Stacks are a concept that combines all the important components of a
Kubernetes cluster

- Configuration of Kubernetes (e.g. Kubeadm)
- Core Applications
- Node Images 

These main 3 elements are combined in Cluster Stacks and tested as a whole,
providing a directly usable distribution for quick and safe creation or upgrade
of production grade Kubernetes clusters. A Cluster Stack is released only if
everything works together, an upgrade from the previous version is possible
and its function thus is ensured. In addition, the SCS Cluster Stack Operator
simplifies the use of Cluster Stacks.

---

## 3. Cluster Stacks in the SCS Ecosystem

Cluster Stacks are a core concept in the Sovereign Cloud Stack (SCS) ecosystem.
They define how Kubernetes clusters are composed, deployed, and managed in a
modular and reproducible way.

SCS is built on the principle of digital sovereignty — the ability to control
and operate cloud infrastructure without relying on proprietary or opaque
technologies. Cluster Stacks contribute to this goal by:

- Standardizing cluster deployments - providing a clear, consistent way to
  define Kubernetes clusters using open, declarative configurations
- Enabling self-determination where organizations can run clusters on their
  own infrastructure or trusted platforms, maintaining full control
- Reducing complexity and simplifying the process of deploying clusters by
  encapsulating best practices into reusable building blocks

It builds on established Kubernetes community projects, especially Cluster API
(CAPI), which provides a Kubernetes-native way to manage cluster lifecycle
operations (create, scale, upgrade, delete).

- Using Cluster API CRDs (Custom Resource Definitions) for defining
  infrastructure and cluster configurations
- Supporting CAPI-compatible providers (e.g., for OpenStack, AWS, Bare Metal)
- Encouraging upstream compatibility, reducing duplication and improving 
  long-term sustainability

---

## 4. Architecture Overview

[SCS Cluster Stacks overview](https://docs.scs.community/docs/container/components/cluster-stacks/components/cluster-stacks/overview/)

Cluster Stacks is packaging components essential for setting up, maintaining
and operating a Kubernetes cluster. They can be divided into three distinct
layers

- cluster-class
- cluster-addons
- node-images

[ClusterClass](https://cluster-api.sigs.k8s.io/tasks/experimental-features/cluster-class/)
is a feature of CAPI which defines the desired configuration and properties of
a Kubernetes cluster as a template - a customizable blueprint.

Cluster addons are core components or services required for the Kubernetes
cluster to function correctly and efficiently. These are not user-facing
applications but rather foundational services critical to the operation and
management of a Kubernetes cluster. They're usually installed and configured
after the cluster infrastructure has been provisioned and before the cluster
is ready to serve workloads.

- Container Network Interfaces (CNI) - plugins that facilitate container
  networking
- Cloud Controller Manager (CCM) - a control plane component that embeds the
  cloud-specific control logic and manages the communication with the
  underlying cloud services
- Konnectivity service is a network proxy that enables connectivity from the
  control plane to nodes and vice versa
- Metrics Server - cluster-wide aggregator of resource usage data

Node images provide the foundation for the operating system environment on each
node of the target Kubernetes cluster. They are typically a minimal operating
system distribution, with needed tools like containerd, kubelet, etc. installed.

In the cluster-stacks repository, the build instructions for Node Images are
always available, but for the deployment a URL of a remote registry or a path
to provider uploaded artifact can be used for provisioning the nodes.

Any change in any of the layers triggers a version bump in the cluster class,
hence the cluster stack. The cluster stack version doesn't simply mirror the
versions of its components, but rather, it reflects the "version of change".
In essence, the cluster stack version is a reflection of the state of the
entire stack as a whole at a particular point in time.


![Cluster Stacks architecture](https://github.com/SovereignCloudStack/cluster-stacks-demo/blob/main/hack/images/syself-cluster-stacks-web.png)

---

## 5. Components and Responsibilities

Cluster API (CAPI) provides declarative APIs and tooling to manage the lifecycle
of Kubernetes clusters. It breaks responsibilities across several core controller
types, each handling a distinct layer of concern. It is responsible for defining
the core cluster objects and their reconciliation logic.

- Cluster - Represents a logical Kubernetes cluster
- Machine - Represents a single Kubernetes node.
- MachineSet, MachineDeployment: Provide scalable sets of Machine objects 
  (like ReplicaSet / Deployment in apps)

Controllers reconcile cluster and machine topology and ensure the right number
and type of machines exist.

Infrastructure Providers (e.g., CAPO for OpenStack, CAPV for vSphere, 
CAPA for AWS) are responsible for provisioning the underlying infrastructure
needed to host Kubernetes clusters.

- Create infrastructure components (VMs, networks, load balancers, disks)
- Reconcile InfrastructureCluster and InfrastructureMachine resources
  (e.g., OpenStackCluster, OpenStackMachine).
- Run in the management cluster, but act on infrastructure outside of it

The structure of the [SCS cluster-stacks repository](https://github.com/SovereignCloudStack/cluster-stacks)
is specifically designed to handle multiple providers, multiple cluster stacks
per provider, and multiple Kubernetes versions per cluster stack. This
organized structure allows to effectively manage, develop, and maintain
multiple cluster stacks across various Kubernetes versions and providers, all
in a single repository.

- Each IaaS Provider has a directory under providers
- Each IaaS Provider can have multiple cluster stack implementations
- Each cluster stack supports multiple Kubernetes major and minor versions

```
providers/
└── <provider_name>/
    └── <cluster_stack_name>/
        └── <k8s_major_minor_version>/
```

Here’s a typical sequence of how these components interact:

- User or GitOps tool (e.g., Flux) creates a Cluster resource with associated
  KubeadmControlPlane and infrastructure references
- Cluster API core controllers observe the new Cluster and spawn Machine and
  KubeadmControlPlane resources
- Bootstrap provider (e.g., CABPK) generates cloud-init/kubeadm configs for
  bootstrapping
- Infrastructure provider provisions actual infrastructure (VMs, networks)
- KubeadmControlPlane bootstraps the Kubernetes control plane
- Additional Machines are created for worker nodes (via MachineDeployment)
- Cluster becomes fully functional, and CAPI controllers continuously reconcile

---

## 6. Quickstart Guide

[SCS Cluster Stacks Quickstart guide](https://docs.scs.community/docs/container/components/cluster-stacks/components/cluster-stacks/providers/openstack/quickstart)

- Prerequisites (KinD, Helm, kubectl, Clusterctl)
  - [KinD](https://kind.sigs.k8s.io/)
  - [Helm](https://helm.sh/)
  - [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
  - [jq](https://jqlang.github.io/jq/)
- [Install clusterctl](https://cluster-api.sigs.k8s.io/user/quick-start.html#install-clusterctl)

```bash
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.9.7/clusterctl-linux-amd64 -o clusterctl
```

- Bootstrap a management cluster with KinD

```bash
kind create cluster --config=kind/kind-cluster-with-extramounts.yaml
```

- Transform it into a management cluster with clusterctl

```bash
export CLUSTER_TOPOLOGY=true
export EXP_CLUSTER_RESOURCE_SET=true
export EXP_RUNTIME_SDK=true
clusterctl init --infrastructure docker
```
- Install CSO
```bash
# Install CSO and CSPO
helm upgrade -i cso \
-n cso-system \
--create-namespace \
oci://registry.scs.community/cluster-stacks/cso \
--set clusterStackVariables.ociRepository=registry.scs.community/kaas/cluster-stacks
```
```shell
kubectl create namespace cluster
```
- Create a basic `clusterstack.yaml` file
```yaml
apiVersion: clusterstack.x-k8s.io/v1alpha1
kind: ClusterStack
metadata:
  name: docker
  namespace: cluster
spec:
  provider: docker
  name: scs
  kubernetesVersion: "1.30"
  channel: custom
  autoSubscribe: false
  noProvider: true
  versions:
    - v0-sha.rwvgrna
```
- Apply `clusterstack.yaml`
```shell
k apply -f clusterstacks/clusterstack.yaml
```
- Create a `cluster.yaml` file
```yaml
apiVersion: cluster.x-k8s.io/v1beta1
kind: Cluster
metadata:
  name: docker-testcluster
  namespace: cluster
  labels:
    managed-secret: cloud-config
spec:
  topology:
    class: docker-scs-1-30-v0-sha.rwvgrna
    controlPlane:
      replicas: 1
    version: v1.30.10
    workers:
      machineDeployments:
        - class: default-worker
          name: md-0
          replicas: 1
```
- Apply cluster.yaml
```shell
k apply -f clusterstacks/cluster.yaml
```
- Get kubeconfig and view cluster node
```shell
clusterctl get kubeconfig -n cluster docker-testcluster > /tmp/kubeconfig
```
```shell
kubectl get nodes --kubeconfig /tmp/kubeconfig
```
- The clusterstack from example installs cilium CNI in the cluster
---

## 7. Configuration and Customization

TODO: Expand outline
[CSCTL](https://github.com/SovereignCloudStack/csctl/blob/main/README.md)
- Download [CSCTL](https://github.com/SovereignCloudStack/csctl/releases/latest)  and unpack
```shell
chmod u+x ~/Downloads/csctl_0.0.2_linux_amd64
sudo mv ~/Downloads/csctl_0.0.2_linux_amd64 /usr/local/bin/csctl
```


---

## 8. Upgrading Cluster Stacks

TODO: Expand outline

- Upgrade paths and strategies
- Kubernetes version upgrades
- Image/version pinning best practices
- Managing node rotation and disruption

---

## 9. Debugging and Observability

TODO: Expand outline

- Common failure points and debugging tools
- Using `kubectl`, logs, and events
- Observability with Prometheus and Grafana
- Health checks and monitoring Cluster Stacks

---

## 10. Cluster Stack Use Cases

TODO: Expand outline

- Single-tenant vs multi-tenant clusters
- Edge deployment scenarios
- Automating fleet management
- Dev/test cluster provisioning

---

## 11. Summary and Further Learning

TODO: Expand outline

- Recap of what you’ve learned
- Tips for production readiness
- Where to go from here (e.g., GitOps, CI/CD integration)
- Community - get help and/or participate
  - Sovereign Cloud Stack is an open community of providers and end-users
    joining forces in defining, implementing and operating a fully open,
    federated, compatible platform
  - You are actively encouraged to contribute either code, documentation
    or issues and to participate in the various discussions happening
    on GitHub or during our various meetings
  - Open community space on [Matrix network](https://matrix.to/#/#scs-community:matrix.org)
  - Check out the [Community calendar](https://docs.scs.community/community/collaboration)
    for information on teams meetings

---

## 12. Appendices and Resources

- [Troubleshooting tips](https://docs.scs.community/docs/container/components/cluster-stacks/components/cluster-stack-operator/topics/troubleshoot)
- [SCS cluster-stacks repository](https://github.com/SovereignCloudStack/cluster-stacks)
- [cluster-stacks-demo repository](https://github.com/SovereignCloudStack/cluster-stacks-demo)
- Links to documentation:
  - [SCS cluster stacks documentation](https://docs.scs.community/docs/category/cluster-stacks)
  - [CAPI official documentation](https://cluster-api.sigs.k8s.io/)
  - [KinD setup guide](https://kind.sigs.k8s.io/docs/user/quick-start/)

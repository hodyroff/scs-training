# SCS Cluster Stacks Course

TODO: Add content, this is just a raw structure

## Course Overview

This course explores the concept of **Cluster Stacks** within the Sovereign Cloud Stack (SCS) ecosystem. We'll break down their architecture, explain how they standardize Kubernetes cluster lifecycles, and dive deep into their deployment, configuration, and evolution. Hands-on examples will guide learners through practical use using KinD or local dev clusters.


## Table of Contents

1. [Introduction](#1-introduction)
2. [What Are Cluster Stacks?](#2-what-are-cluster-stacks)
3. [Cluster Stacks in the SCS Ecosystem](#3-cluster-stacks-in-the-scs-ecosystem)
4. [Architecture Overview](#4-architecture-overview)
5. [Installing a Cluster Stack](#5-installing-a-cluster-stack)
6. [Components and Responsibilities](#6-components-and-responsibilities)
7. [Configuration and Customization](#7-configuration-and-customization)
8. [Upgrading Cluster Stacks](#8-upgrading-cluster-stacks)
9. [Debugging and Observability](#9-debugging-and-observability)
10. [Cluster Stack Use Cases](#10-cluster-stack-use-cases)
11. [Summary and Further Learning](#11-summary-and-further-learning)
12. [Appendices and Resources](#12-appendices-and-resources)

## 1. Introduction

- Course objectives and audience
- Why learn about Cluster Stacks?
- Tools and skills you'll need

## 2. What Are Cluster Stacks?

- Definition and motivation
- How Cluster Stacks relate to Kubernetes clusters
- Abstraction of infrastructure concerns
- Declarative vs imperative management

## 3. Cluster Stacks in the SCS Ecosystem

- Role in SCS's vision for cloud-native sovereignty
- Alignment with upstream projects like Cluster API
- Interoperability with other SCS components (e.g., CAPI controllers, Terraform modules)


## 4. Architecture Overview

- High-level architecture
- Key components:
  - CAPI (Cluster API)
  - Infrastructure providers
  - Bootstrap providers
  - Control plane and worker node configuration
- Lifecycle phases: init → scale → upgrade → delete

## 5. Installing a Cluster Stack

- Prerequisites (KinD, Helm, kubectl, Clusterctl)
- Installing Clusterctl
- Bootstrapping a management cluster with KinD
- Initializing infrastructure providers
- Creating your first workload cluster

## 6. Components and Responsibilities

- Breakdown of responsibilities:
  - Cluster API controllers
  - Infrastructure providers (e.g., CAPO)
  - Bootstrap and control plane providers
- Cluster Stack "flavors" or variants
- How components work together

## 7. Configuration and Customization

- Using `clusterctl` and templates
- YAML structure of a Cluster Stack
- Customizing machine specs, networking, Kubernetes version, etc.
- Integration with SCS Terraform modules

## 8. Upgrading Cluster Stacks

- Upgrade paths and strategies
- Kubernetes version upgrades
- Image/version pinning best practices
- Managing node rotation and disruption

## 9. Debugging and Observability

- Common failure points and debugging tools
- Using `kubectl`, logs, and events
- Observability with Prometheus and Grafana
- Health checks and monitoring Cluster Stacks

## 10. Cluster Stack Use Cases

- Single-tenant vs multi-tenant clusters
- Edge deployment scenarios
- Automating fleet management
- Dev/test cluster provisioning


## 11. Summary and Further Learning

- Recap of what you’ve learned
- Tips for production readiness
- Where to go from here (e.g., GitOps, CI/CD integration)

## 12. Appendices and Resources

- Links to documentation:
  - SCS Cluster Stack GitHub repos
  - CAPI official docs
- KinD setup guide
- Example templates and overlays
- Troubleshooting cheatsheet

# Advanced Operations

Note:
- In this section, we'll cover more advanced operations with ClusterStacks
- We'll explore upgrading clusters, analyzing cluster internals, and troubleshooting
- These skills are essential for operating ClusterStacks in production environments

----

## Upgrading Your Single-Node Cluster

**Task: Perform a Kubernetes version upgrade on your single-node cluster**

- Create a ClusterStack for a newer Kubernetes version
<!-- .element: class="fragment" data-fragment-index="0" -->
- Wait for the corresponding ClusterClass to become available
<!-- .element: class="fragment" data-fragment-index="1" -->
- Update your cluster's class and version references
<!-- .element: class="fragment" data-fragment-index="2" -->
- Monitor the upgrade process as the node is replaced
<!-- .element: class="fragment" data-fragment-index="3" -->

```bash
# Create a ClusterStack for a newer K8s version
cat <<EOF | kubectl apply -f -
apiVersion: clusterstack.x-k8s.io/v1alpha1
kind: ClusterStack
metadata:
  name: openstack-newer
  namespace: cluster
spec:
  provider: openstack
  name: scs
  kubernetesVersion: "1.31"
  channel: custom
  autoSubscribe: false
  versions:
    - v0-sha.newversion
EOF

# Wait for the new ClusterClass to be available
kubectl get clusterclass -n cluster

# Update your single-node cluster to use the new version
kubectl patch cluster openstack-single-node -n cluster --type merge -p '
{
  "spec": {
    "topology": {
      "class": "openstack-scs-1-31-v0-sha.newversion",
      "version": "v1.31.5"
    }
  }
}'

# Monitor the upgrade
kubectl get machines -n cluster -w
clusterctl describe cluster openstack-single-node -n cluster
```

Note:
- This demonstrates upgrading a single-node cluster with ClusterStacks
- The upgrade process works the same way for single-node and multi-node clusters
- Creating a new ClusterStack is the first step - this makes the new version available
- Wait for the CSO to create the new ClusterClass from this ClusterStack
- Updating the cluster is as simple as patching the Cluster resource
- The upgrade will replace the single node with a new one running the updated version
- Because this is a single-node cluster, there will be a brief downtime during the upgrade
- In production multi-node clusters, the upgrade is typically done with rolling updates
- This demonstrates how ClusterStacks makes upgrades declarative and straightforward
- The same pattern applies to larger clusters, but with more complex orchestration behind the scenes

----

## Analyzing Cluster Internals

**Task: Dive into the cluster's internal components**

- Examine core Kubernetes components in kube-system
<!-- .element: class="fragment" data-fragment-index="0" -->
- Explore CNI deployment and configuration
<!-- .element: class="fragment" data-fragment-index="1" -->
- Check add-ons installed by ClusterStacks
<!-- .element: class="fragment" data-fragment-index="2" -->
- Review helm releases managed by the operator
<!-- .element: class="fragment" data-fragment-index="3" -->

```bash
# Switch to your workload cluster
export KUBECONFIG=~/openstack-kubeconfig

# Examine how ClusterStacks configures core components
kubectl describe pod -n kube-system -l component=kube-apiserver
kubectl describe pod -n kube-system -l component=kube-controller-manager
kubectl describe pod -n kube-system -l k8s-app=kube-proxy

# Examine CNI deployment
kubectl get pod -n cilium-system
kubectl -n cilium-system exec ds/cilium -- cilium status

# Examine other add-ons installed by ClusterStacks
kubectl get all -n metrics-server
kubectl get helmreleases -A
```

Note:
- This analysis shows how ClusterStacks configures and manages the Kubernetes components
- Single-node clusters have the same core components as multi-node clusters
- The control plane components (API server, controller manager, scheduler) are configured for the single-node environment
- CSO deploys Cilium as the CNI provider in this example
- ClusterStacks ensures consistent configuration of components across deployments
- Analyzing these internals helps in understanding how the cluster is constructed
- Technical teams will find this useful for debugging and customization
- This insight is valuable when planning upgrades or modifications to the cluster configuration

----

## Troubleshooting

- Check cluster events
  ```bash
  kubectl get events -A --sort-by=.lastTimestamp
  ```

- Use `check-conditions` tool
  ```bash
  go run github.com/guettli/check-conditions@latest all
  ```

- Check cluster status with clusterctl
  ```bash
  clusterctl describe cluster -n cluster openstack-single-node
  ```

- Review logs
  ```bash
  kubectl logs -n cso-system deployment/cso-controller-manager
  ```

Note:
- When things don't work as expected, follow these troubleshooting steps
- Start by checking cluster events - they often provide valuable information
- The check-conditions tool is useful to examine the state of all resources
- clusterctl describe gives a hierarchical view of the cluster's status
- Examining controller logs helps identify issues in the reconciliation process
- Common issues include:
  - Infrastructure provider configuration errors
  - Network connectivity problems
  - Resource constraints
  - Version incompatibilities
- Always check the CAPI and CSO documentation for specific error messages

----

## Configuration and Customization

- ClusterStacks can be configured with environment variables
<!-- .element: class="fragment" data-fragment-index="0" -->
- Custom repositories can be configured as ClusterStack sources
<!-- .element: class="fragment" data-fragment-index="1" -->
- Clusters can be customized through topology variables
<!-- .element: class="fragment" data-fragment-index="2" -->

```bash
# Install envsubst for environment variable expansion
GOBIN=/tmp go install github.com/drone/envsubst/v2/cmd/envsubst@latest

# Configure custom GitHub repository
export GIT_PROVIDER_B64=Z2l0aHVi  # github
export GIT_ORG_NAME_B64=U292ZXJlaWduQ2xvdWRTdGFjaw==  # SovereignCloudStack
export GIT_REPOSITORY_NAME_B64=Y2x1c3Rlci1zdGFja3M=  # cluster-stacks
export GIT_ACCESS_TOKEN_B64=$(echo -n '<my-personal-access-token>' | base64 -w0)

# Configure custom OCI registry
export OCI_REGISTRY_B64=cmVnaXN0cnkuc2NzLmNvbW11bml0eQ==  # registry.scs.community
export OCI_REPOSITORY_B64=cmVnaXN0cnkuc2NzLmNvbW11bml0eS9rYWFzL2NsdXN0ZXItc3RhY2tzCg==  # registry.scs.community/kaas/cluster-stacks

# Deploy CSO with custom configuration
curl -sSL https://github.com/SovereignCloudStack/cluster-stack-operator/releases/latest/download/cso-infrastructure-components.yaml | /tmp/envsubst | kubectl apply -f -
```

Note:
- ClusterStacks' flexibility comes from its rich configuration options
- Environment variables provide a way to customize the deployment
- Envsubst is required to expand environment variables in CSO manifests
- Organizations can use their own repositories as ClusterStack sources
- This enables teams to create and maintain custom stacks
- For GitHub repositories, you need to provide the provider, organization, repository, and access token
- For OCI registries, you provide registry information and credentials
- All sensitive information should be base64 encoded
- Beyond operator configuration, individual clusters can be customized
- The Cluster spec.topology.variables field allows for provider-specific customization
- Common customization include:
  - Compute flavors for control plane and worker nodes
  - Network configurations (CIDRs, external networks)
  - Storage classes and volume configurations
  - Security settings and access controls
- This configuration flexibility is key to adapting ClusterStacks to specific environments

----

## Cluster Configuration Options

```yaml
apiVersion: cluster.x-k8s.io/v1beta1
kind: Cluster
metadata:
  name: custom-cluster
  namespace: cluster
spec:
  clusterNetwork:
    pods:
      cidrBlocks:
        - 192.168.0.0/16
    serviceDomain: cluster.local
    services:
      cidrBlocks:
        - 10.96.0.0/12
  topology:
    variables:
      - name: controller_flavor
        value: "SCS-4V-8-20"
      - name: worker_flavor
        value: "SCS-4V-8-20"
      - name: external_id
        value: "ebfe5546-f09f-4f42-ab54-094e457d42ec"
    class: openstack-alpha-1-29-v2
    controlPlane:
      replicas: 2
    version: v1.29.3
    workers:
      machineDeployments:
        - class: openstack-alpha-1-29-v2
          failureDomain: nova
          name: openstack-alpha-1-29-v2
          replicas: 4
```

Note:
- This example shows how to customize a cluster using topology variables
- The cluster network can be customized for pods and services
- Variables provide provider-specific customization
- For OpenStack, these include:
  - `controller_flavor` and `worker_flavor` - VM flavors for nodes
  - `external_id` - ID of the external network
  - Additional variables for image IDs, security groups, etc.
- This customization capability is important for enterprise environments
- Variables must match what the ClusterClass template expects
- Proper documentation of available variables is essential
- This approach allows standardized deployments while permitting necessary customization
- For full details on available variables, refer to the SCS ClusterStacks documentation

----

## Building Your Own Cluster Stacks

1. Create directory structure:
   - `cluster-class` - CAPI resources
   - `cluster-addon` - Helm charts for addons
   - `node-image` (optional)

2. Generate resources with `clusterctl`
3. Create umbrella charts for addons
4. Build using `csctl` tool

Note:
- Organizations can build their own custom Cluster Stacks
- Start by creating the proper directory structure:
  - cluster-class for CAPI resources and ClusterClass templates
  - cluster-addon for Helm charts of necessary addons
  - optionally, node-image for custom VM images
- Use clusterctl to generate baseline CAPI resources
- Create umbrella Helm charts for add-ons like CNI
- The csctl tool helps build and publish your custom Cluster Stack
- This approach allows for standardization while enabling organization-specific customization
- Custom stacks can incorporate specific security policies or organizational requirements

----

## Exercise 8: Building a Custom ClusterStack

**Task: Create your own custom ClusterStack**
1. Set up the directory structure for a custom stack
2. Customize networking configurations
3. Build and publish your custom stack

```bash
# Create directory structure
mkdir -p my-clusterstack/{cluster-class,cluster-addon}

# Generate base CAPI resources
clusterctl generate cluster my-cluster --infrastructure openstack \
  --kubernetes-version v1.31.5 \
  --control-plane-machine-count=1 \
  --worker-machine-count=2 \
  > my-clusterstack/cluster-class/base.yaml

# Customize networking in the ClusterClass template
# Edit my-clusterstack/cluster-class/base.yaml to change pod CIDR

# Create Helm chart for CNI
mkdir -p my-clusterstack/cluster-addon/templates

# Add custom CNI configuration
cat > my-clusterstack/cluster-addon/templates/cilium.yaml <<EOF
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: cilium
spec:
  chart:
    spec:
      chart: cilium
      version: 1.15.0
      sourceRef:
        kind: HelmRepository
        name: cilium
  values:
    ipam:
      operator:
        clusterPoolIPv4PodCIDR: "192.168.0.0/16"
EOF

# Build the ClusterStack (csctl command would be used here)
```

Note:
- This advanced exercise walks through creating a custom ClusterStack
- The directory structure separates cluster-class (CAPI resources) from cluster-addon (Helm charts)
- clusterctl generate creates a baseline CAPI configuration for your stack
- Customizing networking is a common requirement - edit the CIDR ranges as needed
- The CNI configuration shows how to create a custom Cilium setup
- In a production environment, you would use csctl to build and publish this stack
- Custom stacks allow organizations to standardize their Kubernetes deployments 
- This exercise demonstrates the flexibility of the ClusterStacks approach

----

## Summary and Next Steps

- ClusterStacks provide standardized, sovereign Kubernetes management
<!-- .element: class="fragment" data-fragment-index="0" -->
- They solve real operational challenges in managing multiple clusters
<!-- .element: class="fragment" data-fragment-index="1" -->
- KinD enables user-level access to Kubernetes in SCS environments
<!-- .element: class="fragment" data-fragment-index="2" -->
- Hands-on exercises have given practical experience with the full life-cycle
<!-- .element: class="fragment" data-fragment-index="3" -->

**Get Involved with the Community**
<!-- .element: class="fragment" data-fragment-index="4" -->
- Join the [SCS Matrix space](https://matrix.to/#/#scs-community:matrix.org)
<!-- .element: class="fragment" data-fragment-index="5" -->
- Check the [Community calendar](https://docs.scs.community/community/collaboration)
<!-- .element: class="fragment" data-fragment-index="6" -->
- Contribute code, documentation, or participate in discussions
<!-- .element: class="fragment" data-fragment-index="7" -->

Note:
- We've covered the fundamentals of ClusterStacks in the SCS ecosystem
- We compared various approaches (Magnum, CAPI, ClusterStacks) and their trade-offs
- We explored the architecture that makes standardization and sovereignty possible
- KinD provides an important path for user self-service in SCS environments
- Through our exercises, you've gained practical experience with:
  - Creating management and workload clusters
  - Deploying applications on your clusters
  - Performing Kubernetes version upgrades
  - Troubleshooting common issues
  - Building custom ClusterStacks
- Sovereign Cloud Stack is an open community of providers and end-users
- You are encouraged to participate and contribute to the project:
  - Join the Matrix network community space for discussions
  - Check the Community calendar for regular meetings and events
  - Contribute code, documentation, or report issues on GitHub
  - Participate in the various team discussions and working groups
- Next steps might include:
  - Exploring production deployments on real infrastructure
  - Integration with GitOps workflows using Flux
  - Contributing to the SCS ClusterStacks project
- The skills you've gained are directly applicable to managing Kubernetes at scale

----

## Additional Resources

**Documentation**
- [SCS Cluster Stacks Documentation](https://docs.scs.community/docs/category/cluster-stacks)
- [Cluster API Documentation](https://cluster-api.sigs.k8s.io/)
- [KinD Quick Start Guide](https://kind.sigs.k8s.io/docs/user/quick-start/)

**Repositories**
- [SCS cluster-stacks Repository](https://github.com/SovereignCloudStack/cluster-stacks)
- [Cluster Stacks Demo Repository](https://github.com/SovereignCloudStack/cluster-stacks-demo)
- [Cluster Stack Operator Documentation](https://github.com/SovereignCloudStack/cluster-stack-operator/blob/main/docs/README.md)

**Troubleshooting**
- [SCS Troubleshooting Guide](https://docs.scs.community/docs/container/components/cluster-stacks/components/cluster-stack-operator/topics/troubleshoot)

Note:
- These resources provide further information about ClusterStacks
- The SCS documentation offers comprehensive guidance on all aspects of ClusterStacks
- The Cluster API documentation explains the foundational technology
- The GitHub repositories contain the source code and examples
- The demo repository is particularly useful for learning through examples
- The troubleshooting guide is valuable for resolving common issues
- These resources will help you continue learning and working with ClusterStacks
- Bookmark these links for future reference
- The community is continuously improving the documentation and examples
- If you encounter issues not covered in the documentation, reach out to the community
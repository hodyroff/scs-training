# Implementation and Practice

Note:
- In this section, we'll move from theory to practice
- We'll cover the practical aspects of working with ClusterStacks
- This includes deployment, configuration, and management
- You'll learn the skills needed to implement ClusterStacks in your environment

----

## Required Tools

- **KinD (Kubernetes in Docker)**: Creates local Kubernetes clusters
- **clusterctl**: CLI tool for Cluster API operations
<!-- .element: class="fragment" data-fragment-index="0" -->
- **Helm**: Package manager for Kubernetes applications
<!-- .element: class="fragment" data-fragment-index="1" -->
- **kubectl**: Kubernetes command-line interface
<!-- .element: class="fragment" data-fragment-index="2" -->

Note:
- We use several essential tools to work with ClusterStacks:
- KinD (Kubernetes in Docker) creates local Kubernetes clusters inside Docker containers
  - Perfect for a management cluster that runs the Cluster API controllers
  - Allows for lightweight, isolated testing and development
- clusterctl is the primary CLI for Cluster API
  - Initializes providers in the management cluster
  - Helps create and manage workload clusters
  - Generates cluster templates and configuration
- Helm is the package manager for Kubernetes
  - Used to install the Cluster Stack Operator
  - Manages add-ons and components in workload clusters
  - Provides templating and versioning for deployments
- kubectl is needed for interacting with all Kubernetes clusters
  - We assume familiarity with basic kubectl operations
  - Will use it to examine both management and workload clusters
- These tools work together to create a complete ClusterStacks environment

----

## Installing clusterctl

- Command-line utility provided by Cluster API (CAPI)
- Automates installing Cluster API providers into a management cluster
<!-- .element: class="fragment" data-fragment-index="0" -->
- Helps create workload clusters and manage their lifecycle
<!-- .element: class="fragment" data-fragment-index="1" -->
- Essential for working with ClusterStacks
<!-- .element: class="fragment" data-fragment-index="2" -->

```bash
# Download clusterctl for Linux
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.9.7/clusterctl-linux-amd64 -o clusterctl

# Make it executable
chmod +x clusterctl

# Move to a location in your PATH
sudo mv clusterctl /usr/local/bin/

# Verify installation
clusterctl version
```

For macOS:
```bash
# Download clusterctl for macOS
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.9.7/clusterctl-darwin-amd64 -o clusterctl

# Make it executable
chmod +x clusterctl

# Move to a location in your PATH
sudo mv clusterctl /usr/local/bin/

# Verify installation
clusterctl version
```

Note:
- The `clusterctl` tool is a command-line utility provided by Cluster API (CAPI)
- It automates the process of installing Cluster API providers into a management cluster
- It also helps with creating workload clusters and managing their lifecycle
- Moving it to `/usr/local/bin/` makes it available system-wide
- No sudo is needed for running the commands after installation
- If you prefer not to use sudo for installation, you can install it to `~/bin/` instead (ensure this directory is in your PATH):
  ```bash
  # Alternative installation without sudo
  mkdir -p ~/bin
  mv clusterctl ~/bin/
  # Add to PATH if needed (add this to your ~/.bashrc or ~/.zshrc)
  export PATH=$PATH:~/bin
  ```
- Check for the latest release version on the [Cluster API GitHub releases page](https://github.com/kubernetes-sigs/cluster-api/releases)

----

## Installing Helm

- Helm is the package manager for Kubernetes
- Charts are packages of pre-configured Kubernetes resources
<!-- .element: class="fragment" data-fragment-index="0" -->
- Required for installing the Cluster Stack Operator
<!-- .element: class="fragment" data-fragment-index="1" -->
- Provides versioning, templating, and dependency management
<!-- .element: class="fragment" data-fragment-index="2" -->
- Makes cluster deployments consistent and reproducible
<!-- .element: class="fragment" data-fragment-index="3" -->

```bash
# Download Helm for Linux
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod +x get_helm.sh
./get_helm.sh

# Verify installation
helm version
```

For macOS:
```bash
# Using Homebrew (recommended)
brew install helm

# Verify installation
helm version
```

Note:
- Helm is the package manager for Kubernetes - it simplifies deploying and managing applications
- Charts are packages of pre-configured Kubernetes resources - like templates for applications
- The Cluster Stack Operator (CSO) must be installed with Helm - it's a prerequisite
- Helm provides powerful features like versioning, templating, and dependency management
- ClusterStacks use Helm for both core components and add-ons, ensuring consistency
- No sudo needed for Helm commands after installation
- The installation script automatically adds Helm to your PATH

----

## Exercise 1: Installing Prerequisites

**Task: Install and configure the required tools**
1. Install clusterctl and make it executable
2. Install Helm
3. Verify all tools are working correctly

```bash
# 1. Install clusterctl
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.9.7/clusterctl-linux-amd64 -o clusterctl
chmod +x clusterctl
sudo mv clusterctl /usr/local/bin/

# 2. Install Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod +x get_helm.sh
./get_helm.sh

# 3. Verify installations
clusterctl version
helm version
```

Note:
- This exercise ensures you have all the necessary tools before proceeding
- clusterctl is essential for working with Cluster API resources
- Make the binaries executable with chmod +x before moving them to your PATH
- If you prefer not to use sudo, you can install to ~/bin instead:
  ```bash
  mkdir -p ~/bin
  mv clusterctl ~/bin/
  export PATH=$PATH:~/bin  # Add to ~/.bashrc or ~/.zshrc for persistence
  ```
- The verification steps confirm that everything is installed correctly
- These tools will be used throughout the following exercises

----

## Setting Up a Management Cluster with KinD

- KinD creates Kubernetes clusters running in Docker containers
- Provides a lightweight environment for the management plane
<!-- .element: class="fragment" data-fragment-index="0" -->
- Hosts the Cluster API and ClusterStack Operator controllers
<!-- .element: class="fragment" data-fragment-index="1" -->
- Simplifies testing and development of Kubernetes clusters
<!-- .element: class="fragment" data-fragment-index="2" -->
- Focus remains on the workload clusters we'll create
<!-- .element: class="fragment" data-fragment-index="3" -->

```bash
# Create a KinD cluster for the management plane
kind create cluster --config=kind/kind-cluster-with-extramounts.yaml

# Initialize with CAPI
export CLUSTER_TOPOLOGY=true
export EXP_CLUSTER_RESOURCE_SET=true
export EXP_RUNTIME_SDK=true
clusterctl init --infrastructure openstack
```

Note:
- We use KinD as a simple way to create a Kubernetes cluster for our management plane
- This cluster will host the Cluster API and ClusterStack Operator controllers
- We're not focusing on KinD itself - it's just a convenient tool for our demonstration
- The management cluster runs in Docker, but will create real OpenStack VMs for workload clusters
- The environment variables enable experimental features needed by ClusterStacks
- We initialize the OpenStack infrastructure provider to create workload clusters in OpenStack
- This is a crucial step - it enables the management cluster to interact with OpenStack

----

## Installing Cluster Stack Operator

```bash
# Install CSO with Helm
helm upgrade -i cso \
  -n cso-system \
  --create-namespace \
  oci://registry.scs.community/cluster-stacks/cso \
  --set clusterStackVariables.ociRepository=registry.scs.community/kaas/cluster-stacks

# Create namespace for clusters
kubectl create namespace cluster
```

Note:
- The Cluster Stack Operator (CSO) extends CAPI with add-on management capabilities
- We install it into its own namespace (cso-system) using Helm
- The ociRepository parameter points to the SCS registry where ClusterStack artifacts are stored
- We also create a dedicated namespace for our cluster resources
- With CSO installed, the management cluster is now ready to deploy workload clusters

----

## Preparing OpenStack Authentication

- Create clouds.yaml with OpenStack authentication details
- Set up a Kubernetes secret for OpenStack credentials
<!-- .element: class="fragment" data-fragment-index="0" -->

```bash
# Create clouds.yaml file with your Cloud-in-a-Box credentials
cat > clouds.yaml << EOF
clouds:
  openstack:
    auth:
      auth_url: https://keystone.cloud-in-a-box:5000/v3
      project_name: demo
      username: demo
      password: password
      user_domain_name: Default
      project_domain_name: Default
    region_name: RegionOne
    interface: public
    identity_api_version: 3
EOF

# Create Kubernetes secret with cloud credentials
kubectl create secret generic cloud-config --from-file=clouds.yaml -n cluster
```

Note:
- The OpenStack provider needs credentials to interact with the OpenStack API
- This is critical for creating real OpenStack VMs from your KinD management cluster
- The clouds.yaml format is the standard for OpenStack authentication
- Replace the placeholder values with your actual credentials for your Cloud-in-a-Box environment
- The secret is created in the cluster namespace where we'll deploy our workload clusters
- This secret is automatically used by the ClusterStack Operator when creating OpenStack resources

----

## Creating an OpenStack ClusterStack

```yaml
# ClusterStack definition for OpenStack
apiVersion: clusterstack.x-k8s.io/v1alpha1
kind: ClusterStack
metadata:
  name: openstack
  namespace: cluster
spec:
  provider: openstack
  name: scs
  kubernetesVersion: "1.30"
  channel: custom
  autoSubscribe: false
  versions:
    - v0-sha.rwvgrna
```

```bash
# Apply the ClusterStack
kubectl apply -f openstack-clusterstack.yaml

# Verify the ClusterClass creation
kubectl get clusterclass -n cluster
```

Note:
- We define a ClusterStack for OpenStack that specifies the Kubernetes version
- This is explicitly using the OpenStack provider for our Cloud-in-a-Box environment
- The CSO will download and prepare the necessary cluster stack components
- It creates a ClusterClass that can be referenced by our OpenStack cluster definitions
- Wait for the ClusterClass to be created before proceeding to create the cluster
- You can watch the progress with: kubectl get clusterclass -n cluster -w

----

## Creating a Single-Node OpenStack Cluster

```yaml
# Single-node OpenStack cluster definition
apiVersion: cluster.x-k8s.io/v1beta1
kind: Cluster
metadata:
  name: openstack-single-node
  namespace: cluster
  labels:
    managed-secret: cloud-config
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
        value: "SCS-2V-4-20"  # Use appropriate flavor for your environment
      - name: external_id
        value: "public-network-id"  # Replace with actual network ID
      - name: controlPlaneTaints
        value: []  # Empty array removes the control-plane taint
    class: openstack-scs-1-30-v0-sha.rwvgrna  # Use your actual ClusterClass name
    controlPlane:
      replicas: 1
      # Make control plane nodes schedulable for single-node setup
      machineTemplate:
        metadata:
          annotations:
            cluster.x-k8s.io/remove-machine-taint: ""
    version: v1.30.10
    # No worker nodes defined - single node cluster
```

```bash
# Apply the single-node cluster definition
kubectl apply -f openstack-single-node.yaml

# Monitor cluster creation
kubectl get cluster -n cluster
clusterctl describe cluster openstack-single-node -n cluster
```

Note:
- This creates a single-node Kubernetes cluster in your OpenStack Cloud-in-a-Box environment
- Key configuration for a single-node setup:
  - Setting `controlPlane.replicas: 1` for a single control plane node
  - Adding annotations to remove the control-plane taint
  - Setting `controlPlaneTaints` to an empty array
  - Not defining any worker nodes - everything runs on the control plane
- This single VM will run both the Kubernetes control plane and workloads
- It's ideal for development, testing, or resource-constrained environments
- The VM is created in OpenStack with the specified flavor
- You can adjust the VM size by changing the controller_flavor
- This is a real OpenStack VM, not a container in Docker
- The single-node approach saves resources while providing a full Kubernetes environment

----

## Examining Your OpenStack Cluster

```bash
# Get kubeconfig for your workload cluster
clusterctl get kubeconfig -n cluster openstack-single-node > ~/openstack-kubeconfig
export KUBECONFIG=~/openstack-kubeconfig

# Examine the node setup - note it's a single node with both roles
kubectl get nodes
kubectl describe node | grep -A5 "Taints\|Roles"

# Explore add-ons deployed by ClusterStacks
kubectl get pods -A
kubectl get pods -n kube-system
kubectl get pods -n cilium-system

# Check cluster add-ons configuration
kubectl get helmreleases -A
```

Note:
- After your OpenStack cluster is created, you can interact with it like any Kubernetes cluster
- The nodes are actual OpenStack VMs running in your Cloud-in-a-Box environment
- ClusterStacks automatically deploys essential add-ons:
  - Cilium for networking
  - CoreDNS for DNS resolution
  - Metrics Server for resource monitoring
  - Cloud Controller Manager for OpenStack integration
- These components are configured to work with your OpenStack environment
- This is a real Kubernetes cluster running on real OpenStack VMs

----

## Deploying Applications to Your Cluster

```bash
# Deploy a sample application
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=ClusterIP
kubectl port-forward service/nginx 8080:80

# Access the application
curl localhost:8080

# Inspect resource usage on your cluster
kubectl top nodes
kubectl top pods -A
```

Note:
- After deploying your workload cluster, you can deploy applications just like on any Kubernetes cluster
- The application runs on the OpenStack VMs created by ClusterStacks
- In production, you would likely use services like LoadBalancer or Ingress
- The LoadBalancer service type works with OpenStack if it has Octavia LBaaS installed
- Resource usage monitoring shows the actual resources used by your OpenStack VMs
- ClusterStacks ensures that all necessary components are properly configured

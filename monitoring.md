## Course Overview
This course provides an introduction to SCS Monitoring, a scalable, highly available monitoring stack based on Prometheus, Thanos, Grafana and Loki. The course contains brief overview of used technologies as well as examples and demonstrations using KinD.
## Table of Contents
1. [Introduction](#1-introduction)
2. [Motivation and Use Cases](#2-motivation-and-use-cases)
3. [Monitoring Overview](#3-monitoring-overview)
4. [Example Deployments](#4-example-deployments)
5. [Dashboards and Customization](#5-dashboards-and-customization)
6. [Appendices and Resources](#6-appendices-and-resources)
## 1. Introduction
- Course goals - TODO
- Technologies covered: KinD, Helm, Kubernetes, Prometheus, Thanos, Loki, Grafana
- What to expect by the end of this course - TODO
## 2. Motivation and Use Cases
Monitoring means real-time metrics and logs that inform the operator about current infrastructure state and possible problems. Monitoring makes it easy to detect problems and makes it easier to force
The main features of SCS Monitoring:
- Highly available
- Scalable
- Global view
- Long term metrics and logs
- Infrastructure layer monitoring
- IaaS layer monitoring
- Various types of metrics (Prometheus, StatsD)
- Highly modular
- Highly extensible
- Alerting
- Matrix chat notifications
## 3. Monitoring Overview
This section provides brief explanation of SCS monitoring stack and it's components.
### 3.1. Visualisation and Data Layer
![monitoring1.svg](monitoring1.svg)
- **Data Layer** - for scraping/exporting metrics and logs
	- Prometheus - real-time metrics and alerts based on time-series data.
	- Exporters (Node exporter,SSL exporter, etc.) - exposing metrics for Prometheus
	- Thanos - long-term storage, high availability, multi-cluster
	- Loki - log aggregation
- **Visualization layer** - for visualisation frontend
	- Grafana - analytics and visualization
	- dNation K8S Monitoring - series of intuitive, drill-down Grafana dashboards and Prometheus alerts
### 3.2. Multicluster monitoring
![monitoring3.svg](monitoring3.svg)
- **Workload Cluster** - Contains data layer only. Uses Prometheus to scrape metrics and Thanos to store longterm metrics in an objectstore service
- **Observer cluster** - Contains both data and visual layer. Utilizes Thanos with Envoy proxy for short term queries multiple clusters, hosts and IAASs, including the observer cluster itself. Uses Grafana to display dNation dashboards, as well as any aditional dashboards. For Long term Querries it looks into the objectstore service
### 3.3. IAAS Monitoring
![iaas.png](iaas.png)
IaaS monitoring uses openstack exporter. The user needs to supply credentials in form of `clouds.yaml` Currently, there's no dNation dashboard, we recommend to use [this dashboard](https://grafana.com/grafana/dashboards/21085-openstack-overview/). See [Dashboards and Customization](#5-dashboards-and-customisation) on how to add 3rd party dashboards.
## 4. Example Deployments
This section provides example deployments of single-cluster, multi-cluster and IAAS monitoring as
### 4.1. Quickstart Guide
- Create KinD cluster
```shell
kind create cluster --config kind-observer-config.yaml --image kindest/node:v1.31.6 --name observer
```
- Install monitoring stack  
```shell

helm repo add dnationcloud https://dnationcloud.github.io/helm-hub/

helm repo update dnationcloud

helm upgrade --install dnation-kubernetes-monitoring-stack dnationcloud/dnation-kubernetes-monitoring-stack -f values-observer.yaml

```
- Portforward to Grafana
```bash
kubectl --namespace default port-forward  svc/dnation-kubernetes-monitoring-stack-grafana 3000:80
```
- Access monitoring [http://localhost:30000/d/monitoring/infrastructure-services-monitoring](http://localhost:30000/d/monitoring/infrastructure-services-monitoring)
### 4.2. Multicluster Monitoring
>Todo
- Spawn a workload cluster in KinD - observer was already created in [previous section](#4-1-quickstart-guide), if not please follow it
```shell
kind create cluster --config kind-workload-config.yaml --image kindest/node:v1.31.6 --name workload
```
- Install k8s monitoring on the cluster using `values-observer.yaml`
```shell
helm --kube-context kind-workload  upgrade --install dnation-kubernetes-monitoring-stack dnationcloud/dnation-kubernetes-monitoring-stack -f values-workload.yaml
```
- Now we connect the clusters
#### 4.2.1 Observer Cluster
- Install `cert-manager` 
```shell
helm --kube-context kind-observer install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.17.2 --set crds.enabled=true
```
- Create a self signed issuer and a CA issuer with self-signed ca. Use CA issuer to generate client and server certificate.
```shell
kubectl --context kind-observer  apply -f tls-resources-observer.yaml 
```
- Copy data  from `tls-ca-key-pair`
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: thanos-query-envoy-certs
type: kubernetes.io/tls
data:
  ca.crt: <ca.crt>
  tls.crt: <tls.crt>
  tls.key: <tls.key>
```
- Apply additional observer values to mount this secrets
```shell
helm --kube-context kind-observer upgrade dnation-kubernetes-monitoring-stack dnationcloud/dnation-kubernetes-monitoring-stack -f values-observer.yaml -f values-connect-observer.yaml
```
- Access monitoring [http://localhost:30000/d/monitoring/infrastructure-services-monitoring](http://localhost:30000/d/monitoring/infrastructure-services-monitoring). You will see the box for workload cluster saying `Down`
> Hack: monitoring is domain based, this should make it work locally in Kind
- Add `query-workload.local` to `/etc/hosts`
```
127.0.0.1 query-workload.local
```
- Add `query-workload.local` to `/etc/hosts`
```shell
kubectl --context kind-observer -n kube-system edit configmap coredns
```
```go
hosts {
	// Docker address of localhost, may be different for you
    172.17.0.1  query-workload.local
    fallthrough
}

```
- Restart coredns
#### 4.2.2. Workload Cluster
- Install ingress nginx
```shell
kubectl --context kind-workload apply -f  deploy-ingress-nginx.yaml
```
- Add the following secrets to workload cluster
```yaml
apiVersion: v1
kind: Secret
metadata:
  name:thanos-server
  namespace: monitoring
type: kubernetes.io/tls
data:
# copied from server-secret created by server-certificate (query-workload.local)
  ca.crt: <ca.crt>
  tls.crt: <tls.crt>
  tls.key: <tls.key>

---
apiVersion: v1
kind: Secret
metadata:    
  name: thanos-ca-secret
  namespace: default
data:
  # copy from tls-ca-key-pair
  ca.crt: <ca.crt>

```
- Apply workload observer values to connect the clusters
```bash
 helm --kube-context kind-workload  upgrade --install dnation-kubernetes-monitoring-stack dnationcloud/dnation-kubernetes-monitoring-stack -f values-workload.yaml -f values-connect-workload.yaml 
```
### 4.3 IAAS Monitoring
> Todo
- On observer cluster add the following

## 5. Dashboards and Customization
>Todo
## 6 Appendices and Resources
> Todo
### 6.1. ETCD, Kube-Proxy fix
- The metrics of `etcd` and `kube-proxy` control plane components are by default bound to the localhost that prometheus instances **cannot** access.
- When spawning a new cluster (`kubeadm init`) you can use our config
```bash

kubeadm init --config=helpers/kubeadm_init.yaml

```
- On existing clusters, access the node via SSH and do the following
```bash

# On k8s master node

cd /etc/kubernetes/manifests/

sudo vim etcd.yaml

```
```yaml

# Add listen-metrics-urls as etcd command option

...

- --listen-metrics-urls=http://0.0.0.0:2381

...

```
### 6.2. Resources
[SCS Monitoring Documentation](https://docs.scs.community/docs/operating-scs/components/monitoring/docs/overview)

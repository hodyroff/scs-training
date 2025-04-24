## Overview
[dNation K8S monitoring stack](https://github.com/dNationCloud/kubernetes-monitoring-stack)

- Monitoring stack containing Prometheus, Grafana, Thanos and Loki
- Layered Grafana dashboards
- Multicluster and KaaS monitoring support
 

## Getting started
- Create KinD cluster

```shell
kind create cluster --config kind-observer-config.yaml --image kindest/node:v1.27.3 --name observer
```

- Install monitoring stack 

```shell
helm repo add dnationcloud https://dnationcloud.github.io/helm-hub/
helm repo update dnationcloud
helm upgrade --install dnation-kubernetes-monitoring-stack dnationcloud/dnation-kubernetes-monitoring-stack -f values-observer.yaml
```

- Portforward to Grafana
```bash
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=monitoring" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace default port-forward $POD_NAME 3000
```

- Access monitoring [http://localhost:30000/d/monitoring/infrastructure-services-monitoring](http://localhost:30000/d/monitoring/infrastructure-services-monitoring)
- Demonstration of dashboards

## ETCD, Kube-Proxy fix
- Explain why needed
- Copy fixes from the official docs here
## Multicluster monitoring

- Workload cluster
- Observer cluster
![Multicluster setup](https://raw.githubusercontent.com/dNationCloud/kubernetes-monitoring-stack/refs/heads/main/docs/images/thanos-deployment-architecture.svg)
- Describe the components in the picture and 
- How to setup in KinD/ Demonstration
## IaaS Monitoring (optional)
- Describe how it works
- Demonstration  with an existing openstack (some SCS cloud, dCloud) in KinD
## KaaS Monitoring (optional)
- Describe how it works
- Demonstration with KaaS Mock service
![](https://docs.scs.community/assets/images/monitoring_scs_experimental-3846febea17c1ecf9baaa074ee9b1a10.png)
## Adding dashboards/modifying (optional)
- [Dashboards repo](https://github.com/dNationCloud/kubernetes-monitoring)
- Add dashboard to App/K8S layer
- Adding dashboards from Grafana Hub directly
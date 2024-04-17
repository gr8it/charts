This helmchart will render out ClusterFlow nad ClusterOutput manifests for cattle-logging-system.
There are three predefined flows + outputs corresponding to the three different tenants:

### APP
- global flow used for general user workloads and applications
- includes all namespaces with the exception of `systemNamespaces` (defined in [values.yaml](values.yaml))

### AUDIT
- global flow used for audit logs collected from `rancher-audit-log` and `kube-apiserver` containers

### INFRA
- global flow used for infrastructure logs and `systemNamespaces` (defined in [values.yaml](values.yaml))

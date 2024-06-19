# Logging policies

This helmchart will render out ClusterFlow nad ClusterOutput manifests for cattle-logging-system.

## Flow / output types

There are three predefined flows + outputs corresponding to the three different tenants:

### APP

- global flow used for general user workloads and applications
- includes all namespaces with the exception of `systemNamespaces` (defined in [values.yaml](values.yaml))

### AUDIT

- hosttailer custom resource collects k8s audit logs from file on the control plane node and sends them to pod stdout
- global flow used for audit logs collected from `rancher-audit-log` and `k8s-audit-log` containers

### INFRA

- global flow used for infrastructure logs and `systemNamespaces` (defined in [values.yaml](values.yaml))

## Loki output destinations

For clusters having a cluster label loki set to true, local Loki is used as destination. For all other clusters remote Loki is used

For this to work, fleet templating feature must be used and clusterLabelLoki in values.yaml must be set to:

```yaml
clusterLabelLoki: ${ or (index .ClusterLabels "loki") false }
```

## CA trust bundle

CA trust bundle secret is created only if the cluster does not have Kyverno deployed. If Kyverno is deployed, the CA cert bundle is created by it.

For this to work, fleet templating feature must be used and clusterLabelKyverno in values.yaml must be set to:

```yaml
clusterLabelKyverno: ${ or (index .ClusterLabels "kyverno") false }
```

## Cluster type dependent deployment

Based on the cluster type, i.e. local (=Rancher), or downstream cluster flows / outputs are created.

### Downstream clusters

All [flow types](#flow--output-types) are created.
CA cert bundle is created only if 

### Local (Rancher) cluster

[audit](#audit) flow / output is created only.

# Logging policies

This helmchart will render out ClusterFlow nad ClusterOutput manifests for cattle-logging-system.
There are three predefined flows + outputs corresponding to the three different tenants:

## APP

- global flow used for general user workloads and applications
- includes all namespaces with the exception of `systemNamespaces` (defined in [values.yaml](values.yaml))

## AUDIT

- hosttailer custom resource collects k8s audit logs from file on the control plane node and sends them to pod stdout
- global flow used for audit logs collected from `rancher-audit-log` and `k8s-audit-log` containers

## INFRA

- global flow used for infrastructure logs and `systemNamespaces` (defined in [values.yaml](values.yaml))

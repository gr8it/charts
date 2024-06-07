## Overview
This Helm template is used to create `IsovalentEgressGatewayPolicy` resources for managing egress traffic in a Kubernetes cluster. The template generates policies based on the values provided in the `values.yaml` file.

## Template Structure
The template iterates over a list of policies defined in the `values.yaml` file and generates the necessary Kubernetes resources. Each policy specifies the namespace, destination CIDRs, and egress IPs for the nodes. The `azAffinity` setting controls the affinity of egress gateway traffic to specific availability zones (AZs).

## Template Content
```yaml
{{- if .Values.enabled }}
{{- range .Values.IsovalentEgressGatewayPolicies }}
apiVersion: cilium.io/v1
kind: IsovalentEgressGatewayPolicy
metadata:
  name: {{ .namespace }}-egw-policy
spec:
  destinationCIDRs:
    - 0.0.0.0/0
  selectors:
    - podSelector:
        matchLabels:
          io.kubernetes.pod.namespace: {{ .namespace }}
  azAffinity: {{ .azAffinity | default $.Values.azAffinity | default "localOnlyFirst" }}
  egressGroups:
{{- range .ip }}
  - nodeSelector:
      matchLabels:
        egressgtw: "true"
    egressIP: {{ . }}
  {{- end }}
---
{{- end }}
{{- end }}
```

## Values File Structure
The `values.yaml` file is used to provide the necessary inputs for the template. Here is an example structure of the `values.yaml` file:

```yaml
enabled: true
azAffinity: "localOnly"
IsovalentEgressGatewayPolicies:
  - namespace: app1
    ip:
      - 10.90.31.50
      - 10.90.31.51
    azAffinity: localOnly
  - namespace: app2
    ip:
      - 10.90.31.52
      - 10.90.31.53
    azAffinity: Disabled
```

## azAffinity Settings
It's possible to control the AZ affinity of the egress gateway traffic with azAffinity.

This feature relies on the well-known `topology.kubernetes.io/zone` node label to match or prefer, based on the configured mode of operation, gateway nodes that are within the same AZ of the source pods ("local" gateways). 

There is a global `azAffinity` setting which can be overridden for specific namespaces if needed. If no azAffinity setting is specified, it will default to `localOnlyFirst`. 

- **Global azAffinity Setting**: Defined at the top level of the `values.yaml` file.
- **Namespace-specific azAffinity Setting**: Defined within each policy under `IsovalentEgressGatewayPolicies`.

## azAffinity Modes
- `disabled`: This mode uses all the active gateways available, regardless of their AZ. This is the default mode of operation.
- `localOnly`: This mode selects only local gateways. If no local gateways are available, traffic won't go through the non-local gateways and will be dropped.
- `localOnlyFirst`: This mode selects only local gateways as long as there's at least one gateway available in a given AZ. When no more local gateways are available, non-local gateways will be selected.
- `localPriority`: This mode selects all gateways, but local gateways are picked up first. In conjunction with `maxGatewayNodes`, this can be used to prioritize local gateways over non-local ones, allowing for a graceful fallback to non-local gateways if the local ones become unavailable.

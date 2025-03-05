# BIND Exporter Helm Chart

## Overview

This Helm chart deploys the BIND DNS statistics exporter for Prometheus. The exporter collects statistics from a BIND DNS server's statistics-channel and exports them as Prometheus metrics.

[bind-exporter github page](https://github.com/prometheus-community/bind_exporter)

## Prerequisites

- Kubernetes 1.16+
- Helm 3.x
- BIND DNS server with statistics-channel enabled
- Prometheus Operator (optional, for using PodMonitor)
- Grafana Operator with Prometheus data source configured (optional, for using GrafanaDashboard)

## Features

- Prometheus metrics export for BIND DNS server statistics
- Configurable statistics endpoint
- Prometheus PodMonitor
- Grafana Dashboard for bind-exporter metrics
- Resource management with configurable limits and requests
- Security-hardened defaults:
  - Network policies to restrict traffic
  - Resource limits and requests
  - Liveness and readiness probes

## Installation

### Add Repository

```bash
# Clone this repository or copy the chart files locally
git clone <repository-url>
cd bind-exporter
```

### Chart installation

```bash
helm install <release-name> . \
  --namespace <namespace> \
  --create-namespace \
  --set bindStats.url=<http://bind-server:statistics_port>
```

## Monitoring

### Metrics

Metrics are available at /metrics endpoint on port 9119. Default metrics include:

- BIND server statistics
- Query statistics
- Zone transfer statistics
- Cache statistics

### Pod Monitor

If the Prometheus Operator is installed, enable the PodMonitor.

```yaml
podMonitor:
  enabled: true
  interval: 30s
```

### Grafana Dashboard

The dashboard is deployed automatically with the following configurations:

```yaml
grafanaDashboard:
  enabled: true
  namespace: "apc-observability"
  folder: "apc-observability"
  instanceSelector:
    dashboards: "apc-grafana"
```

Only one dashboard should be deployed. When deploying multiple instances of bind-exporter, for any additional instances set the **grafanaDashboard.enabled=false**

## Troubleshooting

Verify the Installation

```bash
# Check if pod is running
oc get pods -l app.kubernetes.io/name=bind-exporter

# Check pod logs
oc logs -l app.kubernetes.io/name=bind-exporter

# Port forward to test metrics endpoint
kubectl port-forward pod/<bind-exporter-pod-name> 9119:9119
curl http://localhost:9119/metrics
```

### Common Issues

- Can't connect to BIND server
  - Verify BIND statistics-channel is enabled
  - Check network connectivity
  - Verify statsUrl configuration

- PodMonitor not working
  - Verify Prometheus Operator is installed and functioning
  - Check ServiceMonitor labels match Prometheus configuration
  - Check Prometheus logs

## Uninstallation

```bash
helm uninstall <release-name>
```

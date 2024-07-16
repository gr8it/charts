# F5 CIS load balancing

Chart creates Kube API & workload load balancer using F5 CIS on top of RKE2.

## Kube API

Creates a VirtualServer (L7) together with TLS passthrough TLSprofile pointing to a nodeport service of Kube-apiserver pods:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: kube-api-np
  namespace: kube-system
spec:
  selector:
    component: kube-apiserver
  ports:
  - name: https
    nodePort: 30000
    port: 6443
    protocol: TCP
    targetPort: 6443
  externalTrafficPolicy: Local
  sessionAffinity: None
  type: NodePort
```

VirtualServer is recommended, as it integrates with external-dns creating DNS FQDN for the specified VirtualServer. When using VirtualServer (API) and TransportServer (workload) in parallel - the same IP address can't be reused = 2 IP addresses are required. Alternatively TransportServer could be used, with a bogus kubernetes api ingress with strict IP whitelisting (nginx.ingress.kubernetes.io/whitelist-source-range annotation).

## workload (NGINX Ingress Controller - nic)

Creates 2 TransportServers which will result in L4 load balancer setup on BIgIP pointing to the Nginx ingress controller service pods.

The service can be created by Nginx IC helm chart using values:

```yaml
rkeConfig:
  chartValues:
    rke2-ingress-nginx:
      controller:
        service:
          enabled: "true"
          externalTrafficPolicy: Local
          type: NodePort
```

For the integration to work with external-dns, IP address of the F5 LB endpoint must be set as publish status address for the ingress controller, which will be propagated to ingress objects handled by the Nginx ingress controller. This is done using Nginx IC helm chart values:

```yaml
rkeConfig:
  chartValues:
    rke2-ingress-nginx:
      controller:
        extraArgs:
          publish-status-address: 10.0.45.58
```

## Configuration

See [values.yaml](values.yaml)

Note: kubeAPI.IPaddress and ingressController.IPaddress must not be the same!

## How to use

```bash
helm install -n kube-system --value ./values-test.yaml f5-cis-lb .
```

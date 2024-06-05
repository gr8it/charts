# Fleet templating

Very simple helm chart renders input resources as is.

Should be used with [fleet templating](fleet.rancher.io/ref-fleet-yaml#templating) to enable templating in otherwise static manifests.

For example, if you want to make the clusterIssuer dynamic = move content out of cluster-issuer.yaml:

```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: vault.lab.gr8it.cloud
spec:
  acme:
    server: https://vault.lab.gr8it.cloud:8200/v1/pki-int-lab.gr8it.cloud/acme/directory
    privateKeySecretRef:
      name: lab-vault-acme-account-key
    caBundle: ...
    solvers:
    - http01:
        ingress:
          ingressClassName: nginx
```

to an item in values.yaml:

```yaml
items:
- apiVersion: cert-manager.io/v1
  kind: ClusterIssuer
  metadata:
    name: vault.lab.gr8it.cloud
  spec:
    acme:
      server: https://vault.lab.gr8it.cloud:8200/v1/pki-int-lab.gr8it.cloud/acme/directory
      privateKeySecretRef:
        name: lab-vault-acme-account-key
      caBundle: ...
      solvers:
      - http01:
          ingress:
            ingressClassName: nginx
```

and now you can use fleet templating in values.yaml, e.g.:

```yaml
items:
- ...
  spec:
    acme:
      server: https://${ get .ClusterLabels "vaultURL" }/v1/pki-int-lab.gr8it.cloud/acme/directory
  ...
```

## TODO

- multiline string handling is not perfect
  - every input (>,>-,>+,|,|-,|+) ends up the same! with newlines at the end striped
  - other helm charts with extra manifests feature have the same problem

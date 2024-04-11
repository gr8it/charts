# rke2 cluster template

Helm chart that can be used as rke2 cluster template.

Is a fork of <https://github.com/rancher/cluster-template-examples>

## Reference documenation

<https://ranchermanager.docs.rancher.com/reference-guides/cluster-configuration/rancher-server-configuration/rke2-cluster-configuration>

## how to use

```bash
helm install --namespace fleet-default --value ./your-values.yaml my-cluster ./charts
```

General cluster options are available through [values.yaml](./values.yaml)

For different cloud provider drivers:

[Amazonec2](examples/values-aws.yaml)

[Vsphere](examples/values-vsphere.yaml)

[Digitalocean](examples/values-do.yaml)

[Harvester](examples/values-harvester.yaml)

[Azure](examples/values-azure.yaml)

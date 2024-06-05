# Vsphere CSI secret chart

This chart is to generate via Fleet/Rancher templating the value for Vsphere CSI cluster-id. Due to the fact this value needs to be uinque for each cluster and needs to be injected in the vsphere csi secret template. 

In accordance to the docu on <https://github.com/gr8it/conf-lab.gr8it.cloud/tree/main/fleet-applications-common/dev/vsphere-csi>

value for cluster-id will be populated from: 

```yaml
    cluster-id = "{{ .Values.customer }}_{{ .Values.environment }}_{{ .Values.clusterName }}"
```

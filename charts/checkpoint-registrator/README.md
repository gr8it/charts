# Checkpoint registrator

## Checkpoint setup

Checkpoint installation consists of 2 part:

1. cluster registration in Checkpoint Infinity portal (performed by checkpoint-registrator helm chart)
2. installation of checkpoint tools (performed by checkpoint-installer helm chart)

### Checkpoint registrator prerequisites

- namespace called "checkpoint" (default value) with following secrets:
- **checkpoint-registrator-creds** with following keys:
  - api_key: api-key-example
  - api_secret_key: secret-key-example

Complete example of yaml file:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: checkpoint-registrator-creds
  namespace: checkpoint
type: Opaque
stringData:
  api_key: api-key-example
  api_secret_key: secret-key-example
```

> these secrets could be created using init.yaml file (kubectl apply -f init.yaml)
init.yaml file is stored in vault path (lab/checkpoint/cluster/init.yaml)

### proxy settings

- proxy values could be modified in values.yaml
- in case proxy is not needed, comment out this value

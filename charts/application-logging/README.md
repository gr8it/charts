# Application logs collection

Collecting application logs from all application namespaces

Consists of following custom resources:

- cluster output syslog - sends RFC5424 formated logs to syslog server
- cluster output elastic - sends application logs to elastic server (index cluster-all)
- cluster output elastic audit - sends application logs with AUDIT flag to elastic server (index cluster-all-audit)
- cluster flow audit - matches all the logs with tag AUDIT using regular expression from application namespaces
- cluster flow - matches all the logs from application namespaces

All configurable paramaters are in values.yaml

## Prerequisites

- Logging and logging-crd applications (CR) must be installed
- Elastic-search must be installed
- Secret with name "es1-es-elastic-user" with key "elastic" containing password to elastic server must be created in "cattle-logging-system" (so fluentd will be able to login and send data to elastic):

```yaml
apiVersion: v1
stringData:
  elastic: <fillin>
kind: Secret
metadata:
  creationTimestamp: "2024-01-24T14:12:53Z"
  name: es1-es-elastic-user
  namespace: cattle-logging-system
  resourceVersion: "103192"
  uid: ec9a5acf-4f70-43af-a278-b5732dec4fba
type: Opaque
```

Exact value to be taken from secret created upon elastic search creation = secret es1-es-elastic-user in namespace elastic-search!

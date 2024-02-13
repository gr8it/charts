# Helm charts repository

## Requirements

- Helm
- [Helm push plugin](https://github.com/chartmuseum/helm-push)
- Access to repository and Token

### List of helm chart packages provided from gitlab

- [active directory authentication provider](charts/active-directory/)
- [application logging](charts/application-logging/)
- [checkpoint registrator](charts/checkpoint-registrator/)
- [rke2 cluster template](charts/cluster-template/)
- [egress ips](charts/egress-ips/)
- [mongodb express](charts/mongodb-express/)
- [rancher audit log](charts/rancher-audit-log/)

## Usage

### Helm chart from remote location

Refer to Helm chart package using url, e.g.:

```txt
helm template klaster https://raw.githubusercontent.com/gr8it/charts/main/cluster-template-1.0.3.tgz
```

## Build a new helm chart package

Please, use [Makefile](./scripts/Makefile)

```bash
make -C scripts/ build
```

### Publish to a helm repository

To publish the all (local) charts to a remote helm repository such as Gitlab, Harbor, Artifactory, .. be sure to export environment variables for repo URL, user and password:

```bash
export REPO_URL="https://git.pss.sk/api/v4/projects/490/packages/helm/stable"
export REPO_USERNAME="chartpusher"
export REPO_TOKEN="asd1e41123h12ey8haodasd"
```

and run:

```bash
make -C scripts/ publish
```

## Operational guides for charting

- [How to update, create and publish charts](/docs/update_create_publish_charts.md)
- [How to test helm charts](/docs/test_charts.md)

## TODO

- application-logging seems strongly PSS related = move to customer specific repo?

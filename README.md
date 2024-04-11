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
helm template ad https://github.com/gr8it/charts/raw/main/active-directory-auth-provider-1.0.0.tgz
```

> Note: to get the URL, navigate to this repo on github.com, select particular chart, right click raw icon and select Copy link address (or similar)

## Build a new helm chart package

Please, use [Makefile](./scripts/Makefile)

> Don't forget to update helm chart version in Chart.yaml! Otherwise existing version will be replaced!

Run (on the main branch):

```bash
make -C scripts/ build
```

### Publish to Github (raw)

Everything required has been created on filesystem, just push your changes to the main branch (via pull request)

### Publish to a helm repository (Gitlab, Harbor, Artifactory)

To publish the all (local) charts to a remote helm repository such as Gitlab, Harbor, Artifactory, .. be sure to export environment variables for repo URL, user and password:

```bash
export REPO_URL="https://github.com/gr8it/charts/"
export REPO_USERNAME="chartpusher"
export REPO_TOKEN="asd1e41123h12ey8haodasd"
```

and run:

```bash
make -C scripts/ publish
```

## Using the Repo (Github)

```bash
helm repo add gr8it https://raw.githubusercontent.com/gr8it/charts/main/
helm search repo gr8it -l
```

## Operational guides for charting

- [How to update, create and publish charts](/docs/update_create_publish_charts.md)
- [How to test helm charts](/docs/test_charts.md)

## TODO

- application-logging seems strongly PSS related = move to customer specific repo?
- use helm chart repo <https://aspecta.atlassian.net/browse/SPEXAPC-961>

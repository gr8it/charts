# Helm charts repository

## Requirements

- Helm
- [Helm push plugin](https://github.com/chartmuseum/helm-push)
- Access to repository and Token

### List of helm chart packages provided from gitlab

- [active directory authentication provider](charts/active-directory-auth-provider/README.md)
- [application logging](charts/application-logging/README.md)
- [checkpoint registrator](charts/checkpoint-registrator/README.md)
- [rke2 cluster template](charts/cluster-template/README.md)
- [cilium egress gtw ips](charts/cilium-egress-gtw-ips/README.md)
- [mongodb express](charts/mongodb-express/README.md)
- [rancher audit log forwarder](charts/rancher-audit-log-forwarder/README.md)
- [fleet templating](charts/fleet-templating/README.md) - extra / additional manifests universal chart

## Build a new helm chart package

> Don't forget to update helm chart version in Chart.yaml! Otherwise the helm Chart won't be build

Run:

```bash
make -C scripts/ build
```

### Publish to Github (raw)

Everything required has been created on filesystem (index.yaml + packaged_charts/*.tgz), just push your changes to the main branch (via pull request)

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

## Usage

### Github repo

Refers to the Git repo as a helm repository:

```bash
helm repo add gr8it https://raw.githubusercontent.com/gr8it/charts/main/
helm search repo gr8it -l
```

or replace main branch, with feature branch of your choice

> Note: to get the URL, navigate to this repo on github.com, select README.md file, right click raw icon and select Copy link address (or similar) and remove the README.md part.

### Helm chart from remote location

Usage of **[Github repo](#github-repo) method is preferred** to this, as it leaves more space for repo reorganization without the need to change code. Refer to Helm chart package using url, e.g.:

```txt
helm template ad https://github.com/gr8it/charts/raw/main/active-directory-auth-provider-1.0.0.tgz
```

or replace main branch, with feature branch of your choice

> Note: to get the URL, navigate to this repo on github.com, select particular chart .tgz stored in packaged_charts/ directory, right click raw icon and select Copy link address (or similar)

### Fleet usage

Similar to the [Github repo](#github-repo) method, define repo and chart + version in fleet.yaml:

```yaml
helm:
  repo: https://raw.githubusercontent.com/gr8it/charts/main/
  chart: cluster-template
  version: 1.0.14
```

or replace main branch, with feature branch of your choice

## Operational guides for charting

- [How to update, create and publish charts](/docs/update_create_publish_charts.md)
- [How to test helm charts](/docs/test_charts.md)

## TODO

- application-logging seems strongly PSS related = move to customer specific repo?
- use helm chart repo <https://aspecta.atlassian.net/browse/SPEXAPC-961>

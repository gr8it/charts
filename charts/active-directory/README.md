# Rancher Active Directory Auth Provider Configuration

Connects Rancher to Active Directory for authentication / authorization + enables Rancher access for specific AD groups, e.g. cluster administrators.

## Prerequisites

### Authentication setup

Create secret for Active Directory service account by replacing "tajneheslo" with the actual service account password:

```yaml
apiVersion: v1
stringData:
  serviceaccountpassword: tajneheslo
kind: Secret
metadata:
  name: activedirectoryconfig-serviceaccountpassword
  namespace: cattle-global-data
```

### Configuration

Configure values.yaml

## Installation

### Automatic using Fleet

> Automatic fleet installation is not working with fleet version < 0.9 due to missing permissions of the cattle-fleet-local-system-fleet-agent-role cluster role, i.e. can't write CRs!

```yaml
- nonResourceURLs:
  - '*'
  verbs:
  - '*'
```

Please use [manual](#manual) approach below.

### Manual

```bash
git clone <repo> fleet-apps
cd fleet-apps/active-directory
helm template radupc . --no-hooks | k apply -f -
```

Note - [prerequisites](#prerequisites) still apply

When installing manually - [manual uninstall](#manual-uninstall) steps are provided below

## Uninstallation

Uninstallation requires also recreation of the original activedirectory authconfig. Without it it wouldn't be possible to configure active directory auth config even from the GUI

### Manual uninstall

To recreate the origin auth config:

```bash
kubectl replace -f templates/active-directory-auth-provider-original.yaml
```

### Cleanup

You might need to delete all users previously created using active directory. To select such users:

```bash
kubectl get users -o json | jq -c '.items[] | select(.principalIds[] | startswith("activedirectory")) | [.metadata.name, .displayName]'
```

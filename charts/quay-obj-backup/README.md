# Quay image registry configuration backup

This helm chart will deploy Quay configuartion backup solution.  
The solution will gather the configuration, compress it and upload it to S3 bucket.  

## Chart Variables

> [!IMPORTANT]
> - ObjectBucketClaim (backup bucket) is required to be prepared before the HC deployment. The backup bucket is placed in application bucket group and is placed in backup namespace.  
> - Each variable without a default value is mandatory  

|Variable                         | Type | Default                         |  Notes |
|:---                             |:---  |:---                             |:---    |
| clusterName                     | str  |                                 | Name of the Hosted Cluster |
| quayNamespace                   | str  |                                 | Name of the namespace where Quay registry is deployed. |
| backupNamespace                 | str  |                                 | Namespace for deploying the backup job. ObjectBucketClaim must be configured in this namespace beforehand. |
| retentionDays                   | int  | `30`                            | Specifies the number of days to retain old backups during the cleanup phase. |
| selfSignedCertificate.name      | str  | `openshift-service-ca.crt`      | ConfigMap with private CA in pem format. Set this to reference private CA for accessing s3 storage endpoint via local svc url |
| selfSignedCertificate.key       | str  | `service-ca.crt`                | Key name in the ConfigMap that references the private CA file. |
| image.awscli                    | str  | `amazon/aws-cli:2.24.27`                       | Container image with `aws` cli tool |
| image.kctl                      | str  | `bitnami/kubectl:1.31.4`  | Container image with `kubectl` and other tooling needed fot the backup. |
| backupSchedule                  | str  | `"50 23 * * 6"`                   | Cron notation for  backup schedule (once per week). |
| resource.limits.cpu             | str  | `200m`                           | CPU limits for the backup job. |
| resource.limits.memory          | str  | `256Mi`                           | Memory limits for the backup job. |
| resource.requests.cpu           | str  | `50m`                           | CPU requests for the backup job. |
| resource.requests.memory        | str  | `128Mi`                           | Memory requests for the backup job. |  

## Example Deployment
```yaml
# my-values.yaml
quayNamespace: quay
backupNamespace: apc-backup
clusterName: ocpdemo
objectBucketClaim:
  name: app-hub01-quay-backup
```

```sh
$ helm -n apc-backup upgrade -i -f my-values.yaml quay-object-backup .  
Release "quay-object-backup" does not exist. Installing it now.
NAME: quay-object-backup
LAST DEPLOYED: Fri May 16 16:05:51 2025
NAMESPACE: apc-backup
STATUS: deployed
REVISION: 1
TEST SUITE: None
```
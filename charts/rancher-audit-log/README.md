# Rancher audit logging

Enables forwarding of Rancher API audit logs to SIEM syslog server using RFC5424 format (syslog)

Consists of 2 custom resources:

- cluster output - sends RFC5424 formated logs to syslog server
- cluster flow - selects rancher API audit logs from "rancher-audit-log" container

## Prerequisites

Logging and logging-crd applications (CR) must be installed
Rancher logging must be enabled during rancher installation / upgrade process.

More info here: <https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/installation-references/helm-chart-options#api-audit-log>

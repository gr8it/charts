{{/* Application / Chart name */}}
{{- define "quay-obj-backup.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 40 | trimSuffix "-" -}}
{{- end -}}

{{/* Fullname = chart name + cluster name */}}
{{- define "quay-obj-backup.fullname" -}}
{{- $chartName := .Chart.Name | trunc 40 | trimSuffix "-" -}}
{{- $clusterName := .Values.clusterName | trunc 20 | trimSuffix "-" | required "clusterName is required" -}}
{{- printf "%s-%s" $chartName $clusterName | trunc 50 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "quay-obj-backup.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "common.labels" -}}
helm.sh/chart: {{ include "quay-obj-backup.chart" . }}
{{ include "quay-obj-backup.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "quay-obj-backup.selectorLabels" -}}
app.kubernetes.io/name: {{ include "quay-obj-backup.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "quay-obj-backup.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "quay-obj-backup.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

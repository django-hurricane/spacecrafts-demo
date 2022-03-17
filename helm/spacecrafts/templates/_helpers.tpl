{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "spacecrafts.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spacecrafts.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name for celery worker.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spacecrafts.fullnameWorker" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 56 | trimSuffix "-" -}}-worker
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 56 | trimSuffix "-" -}}-worker
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 56 | trimSuffix "-" -}}-worker
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name for celery beat.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spacecrafts.fullnameBeat" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 58 | trimSuffix "-" -}}-beat
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 58 | trimSuffix "-" -}}-beat
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 58 | trimSuffix "-" -}}-beat
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "spacecrafts.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels for deployment
*/}}
{{- define "spacecrafts.labels" -}}
helm.sh/chart: {{ include "spacecrafts.chart" . }}
{{ include "spacecrafts.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels for deployment
*/}}
{{- define "spacecrafts.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spacecrafts.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Common labels for celery worker
*/}}
{{- define "spacecrafts.labelsWorker" -}}
helm.sh/chart: {{ include "spacecrafts.chart" . }}
{{ include "spacecrafts.selectorLabelsWorker" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels for celery worker
*/}}
{{- define "spacecrafts.selectorLabelsWorker" -}}
app.kubernetes.io/name: {{ include "spacecrafts.name" . }}-worker
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Common labels for celery beat
*/}}
{{- define "spacecrafts.labelsBeat" -}}
helm.sh/chart: {{ include "spacecrafts.chart" . }}
{{ include "spacecrafts.selectorLabelsBeat" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels for celery beat
*/}}
{{- define "spacecrafts.selectorLabelsBeat" -}}
app.kubernetes.io/name: {{ include "spacecrafts.name"  . }}-beat
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "spacecrafts.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "spacecrafts.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
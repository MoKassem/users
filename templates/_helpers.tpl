{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "users.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "users.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "users.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Return users image name */}}
{{- define "users.image" -}}
  {{/* docker.io is the default registry - e.g. "qlik/myimage" resolves to "docker.io/qlik/myimage" */}}
  {{- $registry := default "docker.io" .Values.image.registry -}}
  {{- $repository := required "A valid image name entry is required!" .Values.image.repository -}}
  {{/* omitting the tag assumes "latest" */}}
  {{- $tag := (default "latest" .Values.image.tag) | toString -}}
  {{- if .Values.global }}
    {{- if .Values.global.imageRegistry }}
      {{- printf "%s/%s:%s" .Values.global.imageRegistry $repository $tag -}}
    {{- else -}}
      {{- printf "%s/%s:%s" $registry $repository $tag -}}
    {{- end -}}
  {{- else -}}
    {{- printf "%s/%s:%s" $registry $repository $tag -}}
  {{- end -}}
{{- end -}}

{{- define "ingressClass" -}}
  {{- $ingressClass := .Values.ingress.class -}}
  {{- if .Values.global -}}
    {{- if .Values.global.ingressClass -}}
      {{- $ingressClass = .Values.global.ingressClass -}}
    {{- end -}}
  {{- end -}}
  {{- printf "%s" $ingressClass -}}
{{- end -}}

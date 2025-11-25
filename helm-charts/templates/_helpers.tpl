{{- define "frontend.name" -}}
{{ include "frontend.fullname" . }}
{{- end }}

{{- define "frontend.fullname" -}}
{{ .Chart.Name }}
{{- end }}

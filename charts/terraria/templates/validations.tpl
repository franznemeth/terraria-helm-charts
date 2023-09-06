{{- $maxPlayersBase := int .Values.server.maxPlayers.base }}
{{- if le $maxPlayersBase 0 }}
  {{- fail (printf "maxPlayers '%d' is invalid, must be greater than 0" $maxPlayersBase) }}
{{- else if ge $maxPlayersBase 256 }}
  {{- fail (printf "maxPlayers '%d' is invalid, must be smaller than 256" $maxPlayersBase) }}
{{- end }}
{{- if .Values.ingress.enabled }}
  {{- if not (or .Values.rest.enabled .Values.flyingsnake.enabled )}}
    {{- fail (printf "if ingress.enabled=true either rest.enabled or/and flyingsnake.enabled must be set to true") }}
  {{- end }}
{{- end }}

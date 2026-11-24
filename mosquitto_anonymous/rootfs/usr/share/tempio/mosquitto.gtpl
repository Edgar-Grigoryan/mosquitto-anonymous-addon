user root
{{ if .log_dest }}
# custom log_dest
{{ range .log_dest }}log_dest {{ . }}
{{ end }}
{{ else }}
log_dest stdout
{{ end }}
{{ if .debug }}
log_type all
{{ else if .log_type }}
{{ range .log_type }}log_type {{ . }}
{{ end }}
{{ else }}
log_type error
log_type warning
log_type notice
log_type information
{{ end }}
log_timestamp_format %Y-%m-%d %H:%M:%S
persistence true
persistence_location /data/

# Limits
# max_queued_messages is effectively the upper limit of
# the number of entities on Home Assistant if startup
# is busy and cannot read messages fast enough
max_queued_messages 8192

# Anonymous access: accept every client and ignore any username/password
# it sends. No authentication plugin is loaded.
allow_anonymous true

{{ if .customize }}
include_dir /share/{{ .customize_folder }}
{{ end }}

listener 1883
protocol mqtt

listener 1884
protocol websockets

{{ if .ssl }}

# Follow SSL listener if a certificate exists
listener 8883
protocol mqtt
{{ if .cafile }}
cafile {{ .cafile }}
{{ else }}
cafile {{ .certfile }}
{{ end }}
certfile {{ .certfile }}
keyfile {{ .keyfile }}
require_certificate {{ .require_certificate }}

listener 8884
protocol websockets
{{ if .cafile }}
cafile {{ .cafile }}
{{ else }}
cafile {{ .certfile }}
{{ end }}
certfile {{ .certfile }}
keyfile {{ .keyfile }}
require_certificate {{ .require_certificate }}

{{ end }}

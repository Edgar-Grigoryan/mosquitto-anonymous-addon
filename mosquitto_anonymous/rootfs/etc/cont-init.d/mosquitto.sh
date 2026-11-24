#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# Configures mosquitto (anonymous access, no users)
# ==============================================================================
declare cafile
declare certfile
declare keyfile
declare log_dest
declare log_type
declare ssl

keyfile="/ssl/$(bashio::config 'keyfile')"
certfile="/ssl/$(bashio::config 'certfile')"
cafile="/ssl/$(bashio::config 'cafile')"
if bashio::fs.file_exists "${certfile}" \
  && bashio::fs.file_exists "${keyfile}";
then
  bashio::log.info "Certificates found: SSL is available"
  ssl="true"
  if ! bashio::fs.file_exists "${cafile}"; then
    cafile="${certfile}"
  fi
else
  bashio::log.info "SSL is not enabled"
  ssl="false"
fi

# Get log options as raw JSON types for tempio
options=$(bashio::addon.config)
log_dest=$(jq -c ".log_dest" <<<"$options")
log_type=$(jq -c ".log_type" <<<"$options")

# Generate mosquitto configuration.
bashio::var.json \
  cafile "${cafile}" \
  certfile "${certfile}" \
  customize "^$(bashio::config 'customize.active')" \
  customize_folder "$(bashio::config 'customize.folder')" \
  keyfile "${keyfile}" \
  log_dest "^${log_dest}" \
  log_type "^${log_type}" \
  require_certificate "^$(bashio::config 'require_certificate')" \
  ssl "^${ssl}" \
  debug "^$(bashio::config 'debug')" \
  | tempio \
    -template /usr/share/tempio/mosquitto.gtpl \
    -out /etc/mosquitto/mosquitto.conf

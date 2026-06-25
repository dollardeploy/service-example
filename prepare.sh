#!/bin/bash
set -e

# prepare.sh runs as the app user from inside ~/services/example on every host
# prepare. It must be idempotent: a non-zero exit fails the whole host prepare.
#
# Available in the environment:
#   SERVICE_ID  - this service's id (use it to build the env marker prefix)
#   HOST_ID     - the host id
#   plus all host deploy env vars, including any values this service emitted on
#   a previous prepare (re-injected as SERVICE_CUSTOM_${SERVICE_ID}_<NAME>).

# 1. Emit a static custom env var. The SERVICE_CUSTOM_${SERVICE_ID}_ prefix is
#    mandatory — only prefixed markers are persisted for the service.
echo "{{env:SERVICE_CUSTOM_${SERVICE_ID}_EXAMPLE_GREETING:hello from example service}}"

# 2. Emit a generated secret, but only generate it once. On the next prepare it
#    comes back in the environment, so reuse it to stay idempotent.
existing_token_var="SERVICE_CUSTOM_${SERVICE_ID}_EXAMPLE_API_TOKEN"
existing_token="${!existing_token_var:-}"

if [ -z "$existing_token" ]; then
  echo "example: generating a new API token"
  existing_token="$(head -c 24 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | head -c 32)"
else
  echo "example: reusing existing API token"
fi

echo "{{env:SERVICE_CUSTOM_${SERVICE_ID}_EXAMPLE_API_TOKEN:$existing_token}}"

echo "example: prepare complete"

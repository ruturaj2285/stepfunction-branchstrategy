#!/usr/bin/env bash
set -euo pipefail
WF_DIR="${1:-}"
ENV="${2:-dev}"

if [[ -z "$WF_DIR" ]]; then
  echo "Usage: deploy_step_function.sh <step-function-workflow/<env>/<name>> <env>"
  exit 1
fi

NAME="$(basename "$WF_DIR")"
SFN_NAME="${NAME}-${ENV}"
DEFINITION_FILE="${WF_DIR}/state_machine.json"

echo "Updating Step Function: ${SFN_NAME} from ${DEFINITION_FILE}"

aws stepfunctions update-state-machine \
  --state-machine-arn "arn:aws:states:${AWS_REGION}:${AWS_ACCOUNT_ID}:stateMachine:${SFN_NAME}" \
  --definition "file://${DEFINITION_FILE}" >/dev/null

echo "Updated Step Function: ${SFN_NAME}"

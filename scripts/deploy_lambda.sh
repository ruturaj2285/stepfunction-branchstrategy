#!/usr/bin/env bash
set -euo pipefail
LAMBDA_DIR="${1:-}"
ENV="${2:-dev}"

if [[ -z "$LAMBDA_DIR" ]]; then
  echo "Usage: deploy_lambda.sh <functions/<name>> <env>"
  exit 1
fi

NAME="$(basename "$LAMBDA_DIR")"
FUNCTION_NAME="${NAME}-${ENV}"
ZIP="/tmp/${NAME}.zip"

echo "Packaging ${FUNCTION_NAME} from ${LAMBDA_DIR}"

# Package (Python example)
pushd "$LAMBDA_DIR" >/dev/null
rm -f "$ZIP"
pip install -r requirements.txt -t . >/dev/null 2>&1 || true
zip -r "$ZIP" . -x "*.md" >/dev/null
popd >/dev/null

# Update function code (function must exist; for POC we skip create)
aws lambda update-function-code \
  --function-name "$FUNCTION_NAME" \
  --zip-file "fileb://${ZIP}" >/dev/null

echo "Deployed Lambda: $FUNCTION_NAME"

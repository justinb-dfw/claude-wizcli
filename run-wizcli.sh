#!/bin/bash
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"
WIZCLI="$SKILL_DIR/wizcli"
TOKEN_FILE="$HOME/.wiz-token"

# Auth method 1: Service account via ~/.wiz-token
if [ -f "$TOKEN_FILE" ]; then
  export WIZ_CLIENT_ID=$(grep '^id:' "$TOKEN_FILE" | cut -d: -f2)
  export WIZ_CLIENT_SECRET=$(grep '^secret:' "$TOKEN_FILE" | cut -d: -f2-)
  exec "$WIZCLI" "$@"
fi

# Auth method 2: Device code OAuth (interactive — opens browser)
# If no token file, check if already authenticated (wizcli caches session)
exec "$WIZCLI" "$@"

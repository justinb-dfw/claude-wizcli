#!/bin/bash
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"
WIZCLI="$SKILL_DIR/wizcli"
TOKEN_FILE="$HOME/.wiz-token"

if [ ! -f "$TOKEN_FILE" ]; then
  echo "ERROR: ~/.wiz-token not found" >&2
  exit 1
fi

export WIZ_CLIENT_ID=$(grep '^id:' "$TOKEN_FILE" | cut -d: -f2)
export WIZ_CLIENT_SECRET=$(grep '^secret:' "$TOKEN_FILE" | cut -d: -f2-)

exec "$WIZCLI" "$@"

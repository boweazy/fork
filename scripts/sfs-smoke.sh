#!/usr/bin/env bash
set -euo pipefail
: "${SFS_APP_URL:?Set SFS_APP_URL to your Replit URL}"
echo "== /health =="; CODE="$(curl -sS -m 10 -o /tmp/h.out -w "%{http_code}" "$SFS_APP_URL/health" || true)"
echo "HTTP $CODE"; head -c 300 /tmp/h.out || true; echo
echo "== /api/boost =="; curl -sS -m 10 "$SFS_APP_URL/api/boost" | head -c 300 || echo "[no response]"; echo
echo "PORT=${PORT:-<unset>} NODE_ENV=${NODE_ENV:-<unset>}"

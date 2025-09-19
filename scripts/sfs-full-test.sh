#!/usr/bin/env bash
set -euo pipefail
out="/mnt/data/sfs-test-$(date +%Y%m%d-%H%M%S).txt"
log(){ printf "%s\n" "$*" | tee -a "$out"; }
ok(){ pass=$((pass+1)); log "✅ $1"; }
ng(){ fail=$((fail+1)); log "❌ $1"; }
pass=0; fail=0

if [ -z "${SFS_APP_URL:-}" ]; then
  log "❗ SFS_APP_URL is not set. Copy your Replit URL from “Open in Browser”."
  exit 2
fi
log "🌐 Testing $SFS_APP_URL"

code=$(curl -sS -m 8 -o /tmp/h.out -w "%{http_code}" "$SFS_APP_URL/health" || true)
[ "$code" = "200" ] && ok "/health 200" || { ng "/health got $code"; head -c 200 /tmp/h.out | tee -a "$out"; echo | tee -a "$out"; }

bdy=$(curl -sS -m 8 "$SFS_APP_URL/api/boost" || true)
[ -n "$bdy" ] && ok "/api/boost responded" || ng "/api/boost no response"

hdrs=$(curl -sSI -X OPTIONS -H 'Origin:https://smartflow.site' -H 'Access-Control-Request-Method: GET' "$SFS_APP_URL/api/boost" || true)
echo "$hdrs" | grep -iq 'access-control-allow-origin' && ok "CORS header present" || ng "CORS header missing"

home=$(curl -sS -m 8 "$SFS_APP_URL/" || true)
echo "$home" | grep -qi 'smartflow' && ok "Landing copy present" || ng "Landing copy missing"
echo "$home" | grep -qiE 'data-test="copy-btn"|Copy' && ok "Copy button present" || ng "Copy button missing"

pt=$(curl -sS -m 8 -o /dev/null -w "%{http_code}" "$SFS_APP_URL/data/../app.py" || true)
case "$pt" in 400|401|403) ok "Traversal blocked ($pt)";; *) ng "Traversal NOT blocked (got $pt)";; esac

log "--- Summary: $pass passed, $fail failed ---"
log "📄 Report saved to: $out"
[ "$fail" -eq 0 ]

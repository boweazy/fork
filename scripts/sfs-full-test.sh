#!/usr/bin/env bash
set -euo pipefail
: "${SFS_APP_URL:?Set SFS_APP_URL, e.g. https://<your-repl>.replit.app}"
fail=0; pass=0; out="/mnt/data/sfs-test-$(date +%Y%m%d-%H%M%S).txt"

log(){ printf "%s\n" "$*" | tee -a "$out"; }
ok(){ pass=$((pass+1)); log "✅ $1"; }
ng(){ fail=$((fail+1)); log "❌ $1"; }

# 1) /health
code=$(curl -sS -m 8 -o /tmp/h.out -w "%{http_code}" "$SFS_APP_URL/health" || true)
[ "$code" = "200" ] && ok "/health 200" || ng "/health got $code"

# 2) /api/boost
bdy=$(curl -sS -m 8 "$SFS_APP_URL/api/boost" || true)
[ -n "$bdy" ] && ok "/api/boost responded" || ng "/api/boost no response"

# 3) CORS preflight (v0.2)
hdrs=$(curl -sSI -X OPTIONS -H 'Origin:https://smartflow.site' -H 'Access-Control-Request-Method: GET' "$SFS_APP_URL/api/boost" || true)
echo "$hdrs" | grep -iq 'access-control-allow-origin' && ok "CORS header present" || ng "CORS header missing"

# 4) Landing copy + Copy button (v0.2)
home=$(curl -sS -m 8 "$SFS_APP_URL/" || true)
echo "$home" | grep -qi 'smartflow' && ok "Landing copy present" || ng "Landing copy missing"
echo "$home" | grep -qiE 'data-test="copy-btn"|Copy' && ok "Copy button present" || ng "Copy button missing"

# 5) Counter (v0.2)
cnt=$(curl -sS -m 8 "$SFS_APP_URL/api/counter" || curl -sS -m 8 "$SFS_APP_URL/counter" || true)
[ -n "$cnt" ] && ok "Counter endpoint responded" || ng "Counter endpoint missing"

# 6) Public link meta
echo "$home" | grep -qi 'og:url' && ok "og:url present" || ng "og:url missing"

# 7) Path traversal hardening (/data)
pt_code=$(curl -sS -m 8 -o /dev/null -w "%{http_code}" "$SFS_APP_URL/data/../app.py" || true)
case "$pt_code" in 400|401|403) ok "Traversal blocked ($pt_code)";; *) ng "Traversal NOT blocked (got $pt_code)";; esac

# Summary
log "--- Summary: $pass passed, $fail failed ---"
log "Report: $out"
[ "$fail" -eq 0 ] || exit 1

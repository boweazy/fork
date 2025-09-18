#!/usr/bin/env bash
set -euo pipefail
cmd="${1:-help}"
case "$cmd" in
  clean) rm -rf node_modules .cache 2>/dev/null || true; echo "Cleaned caches." ;;
  tree)  find . -maxdepth 3 -type f -not -path "*/node_modules/*" -printf "%p\t%k KB\n" | sort ;;
  big)   find . -type f -not -path "*/node_modules/*" -size +1M -print ;;
  *)     echo "Usage: $0 {clean|tree|big}"; exit 1 ;;
esac

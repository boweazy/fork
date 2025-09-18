#!/usr/bin/env bash
set -euo pipefail
TS="$(date +%Y%m%d-%H%M%S)"
OUT="/mnt/data/sfs-backup-$TS.tgz"
tar --exclude=node_modules --exclude=.git -czf "$OUT" .
echo "Backup written: $OUT"

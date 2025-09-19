#!/usr/bin/env bash
set -euo pipefail
branch="${1:-main}"
echo "🔄 Pulling $branch..."
git fetch origin "$branch" || echo "Warning: Could not fetch from origin"
git reset --hard "origin/$branch" || echo "Warning: Could not reset to origin/$branch"
if [ -f package.json ]; then npm ci --omit=dev || npm install; fi
echo "✅ Sync complete"
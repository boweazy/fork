#!/usr/bin/env bash
set -euo pipefail
: "${ORG:?}"; : "${REPO:?}"; : "${GITHUB_PAT:?GitHub PAT missing}"
REMOTE="https://${GITHUB_PAT}@github.com/${ORG}/${REPO}.git"
git init -q
git config user.name  "${GIT_USER_NAME:-SmartFlow Replit}"
git config user.email "${GIT_USER_EMAIL:-replit@smartflow.local}"
git remote remove origin 2>/dev/null || true
git remote add origin "$REMOTE"
git add -A
git commit -m "chore: sync from Replit $(date -u +%F-%T)" || echo "No changes to commit."
git branch -M main
git push -u origin main
echo "Pushed to https://github.com/${ORG}/${REPO}"

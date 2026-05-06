#!/usr/bin/env bash
set -e

BRANCH="feat/$(date +%s)"
MSG="${1:-feat: update}"

git checkout -b "$BRANCH"
git add .
git commit -m "$MSG"
git push -u origin "$BRANCH"

gh pr create \
  --title "$MSG" \
  --body "Automated PR from local changes" \
  --base main \
  --head "$BRANCH"

# Merge mengikuti kebijakan repo
gh pr merge --merge --delete-branch

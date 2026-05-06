#!/usr/bin/env bash
set -e

# ===== CONFIG =====
BASE_BRANCH="main"
AUTO_MERGE=true   # ubah ke false kalau mau merge manual
MSG="chore: update data"

# ===== STEP 1: pastikan di main =====
git checkout $BASE_BRANCH
git pull origin $BASE_BRANCH

# ===== STEP 2: buat branch unik =====
BRANCH="feat/$(date +%s)"
git checkout -b $BRANCH

# ===== STEP 3: update data.txt =====
echo "$(date '+%Y-%m-%d %H:%M:%S')" >> data.txt

# ===== STEP 4: commit & push =====
git add data.txt
git commit -m "$MSG"
git push -u origin $BRANCH

# ===== STEP 5: buat PR =====
gh pr create \
  --title "$MSG" \
  --body "auto update data.txt" \
  --base $BASE_BRANCH \
  --head $BRANCH

# ===== STEP 6: merge (opsional) =====
if [ "$AUTO_MERGE" = true ]; then
  gh pr merge --merge --delete-branch
fi

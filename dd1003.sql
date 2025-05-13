#!/bin/bash

# Branch to clean up
TARGET_BRANCH="develop"
WORK_BRANCH="develop-cleaned"

# Checkout from develop to a new branch to work on
git checkout $TARGET_BRANCH
git checkout -b $WORK_BRANCH

# Read ignore.txt which contains tags like RA-1, RB-2
while read -r TAG; do
  echo "Processing tag: $TAG"
 
  # Get the commit hash for the tag
  COMMIT_HASH=$(git rev-list -n 1 "$TAG")

  if [ -z "$COMMIT_HASH" ]; then
    echo "Tag $TAG not found, skipping..."
    continue
  fi

  # Revert the commit
  echo "Reverting commit $COMMIT_HASH for tag $TAG"
  git revert --no-edit "$COMMIT_HASH"

done < ignore.txt

echo "Done. Cleaned branch is $WORK_BRANCH"
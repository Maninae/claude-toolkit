---
description: Git Commit and Push (gmp)
---

# /gmp - Commit and Push

Workflow to stage, commit, and push changes in one go. Runs without confirmation.

// turbo-all

## Steps

1. Check status and stage all changes:
   ```bash
   git status --short
   git add -A
   ```

2. Generate a conventional commit message based on the changes and commit immediately:
   ```bash
   git commit -m "GENERATED_MESSAGE"
   ```

3. Push to origin/main:
   ```bash
   git push origin main
   ```

4. Confirm success:
   ```bash
   git log --oneline -1
   ```

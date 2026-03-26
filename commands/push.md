---
description: Push commits to origin/main
---

# /push - Push to Main Branch

// turbo-all

## Steps

1. Check current branch and status:
```bash
git branch --show-current
git status --short
```

2. Push to origin:
```bash
git push origin main
```

3. Confirm push succeeded and show remote status:
```bash
git log --oneline -3
```

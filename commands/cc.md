---
description: Check current context token usage in this conversation
---

# /cc - Context Check

When the user runs `/cc`, provide a quick status update on the conversation context:

## What to Report

1. **Estimated token usage**: Based on the conversation length and complexity
2. **Files viewed this session**: List of files that have been read
3. **Files edited this session**: List of files that have been modified
4. **Recommendation**: Whether context is getting full and we should wrap up soon

## Format

```
📊 Context Check
───────────────────────────────
Tokens: ~XX,XXX / 200,000 (XX%)
Files viewed: N
Files edited: N

Status: [🟢 Plenty of room | 🟡 Getting full | 🔴 Near limit]

[Optional: Recommendation if context is getting full]
```

## Notes
- Use double newlines in order for it to format in the UI as a line break!
- Token count is an estimate based on conversation activity
- If context is above 70%, suggest wrapping up or starting fresh
- If context is above 90%, strongly recommend `/wrapup`

---
description: Create a git commit with auto-generated description
---

# /commit - Create Git Commit

When the user runs `/commit`, do the following:

## Steps

1. Run `git status` to see what's staged/changed
2. Run `git diff --cached --stat` to see staged changes
3. If nothing is staged, run `git add -A` to stage all changes
4. Generate a commit message based on the changes:
   - Use conventional commit format: `type: description`
   - Types: `feat`, `fix`, `refactor`, `docs`, `chore`, `test`
   - Include a multi-line description for significant changes
5. Show the user the proposed commit message
6. Run `git commit -m "message"` with the generated message

## Commit Message Format

```
type: Short summary (imperative mood)

Longer description if needed:
- Bullet points for major changes
- Include file names when helpful
- Mention breaking changes
```

## Examples

- `feat: Add user authentication system`
- `fix: Resolve null pointer in data parser`
- `refactor: Extract common utilities to shared module`
- `docs: Add architecture documentation`

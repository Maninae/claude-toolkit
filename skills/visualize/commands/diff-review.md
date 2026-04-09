---
name: diff-review
description: Visual diff review with architecture diagram and code walkthrough. Use when reviewing changes, PRs, or recent commits.
argument-hint: [branch or commit range, e.g. "HEAD~3" or "feature-branch"]
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, AskUserQuestion, ToolSearch
---

# Diff Review

Generate a visual diff review — an HTML page that presents code changes with architecture context, organized by concern rather than by file.

## Invocation

```
/diff-review                     # Review uncommitted changes
/diff-review HEAD~3              # Review last 3 commits
/diff-review main..feature       # Review branch diff
/diff-review --slides            # Output as slide deck
```

## Workflow

1. **Gather the diff**:
   - No args → `git diff` (staged + unstaged) + `git diff --cached`
   - Commit range → `git diff <range>` + `git log --oneline <range>`
   - Branch → `git diff <base>..<branch>` + `git log --oneline <base>..<branch>`

2. **Analyze changes**:
   - Group changes by concern (not by file): "Auth changes", "Database migration", "UI updates"
   - Identify the architectural impact: does this change cross boundaries?
   - Flag risks: breaking changes, security-sensitive code, performance implications
   - Note test coverage: are changed paths covered by tests?

3. **Read design references**:
   - Read `references/_principles.md` for creative brief and anti-slop rules
   - Use the **Diff Review** variant of the Report archetype
   - Complete the creative brief before generating HTML

4. **Generate HTML** with these sections:
   - **Overview**: One-paragraph summary of what changed and why
   - **Architecture Diagram**: Mermaid diagram showing affected components and their relationships
   - **Change Groups**: Each group gets a heading, description, and syntax-highlighted diff blocks
   - **Risk Assessment**: Callout boxes for flagged risks (breaking changes, security, performance)
   - **Stats**: Files changed, lines added/removed, commits included

5. **Write** to `~/.visualize/YYYY-MM-DD/diff-review/index.html` and open in browser.

## Quality Checklist

- Changes grouped by concern, not alphabetically by filename
- Architecture diagram shows WHERE in the system changes occur
- Risk flags are specific ("SQL injection risk in user input handling"), not generic ("security concern")
- Code blocks have syntax highlighting and filename labels
- Stats are accurate (match `git diff --stat`)

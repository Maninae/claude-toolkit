---
name: project-recap
description: Mental model snapshot for context-switching back to a project. Captures architecture, recent changes, open threads, and key files.
argument-hint: [time range, e.g. "2w" for last 2 weeks, or blank for full recap]
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, AskUserQuestion, ToolSearch
---

# Project Recap

Generate a visual project recap — a mental model snapshot that helps you context-switch back into a project after time away.

## Invocation

```
/project-recap                    # Full project recap
/project-recap 2w                 # Focus on last 2 weeks of activity
/project-recap --slides           # Output as slide deck
```

## Workflow

1. **Gather project state**:
   - `git log --oneline -50` (or filtered by time range) for recent activity
   - `git shortlog -sn --since="<range>"` for contributor activity
   - Key files: README, package.json/Cargo.toml/pyproject.toml, config files
   - Directory structure overview (`ls` top-level, key subdirectories)
   - Open issues/PRs if `gh` CLI is available

2. **Analyze architecture**:
   - Identify major modules/packages and their responsibilities
   - Map dependencies between modules
   - Identify entry points (main files, API routes, CLI commands)
   - Note tech stack (languages, frameworks, databases, external services)

3. **Identify open threads**:
   - TODO/FIXME/HACK comments in code
   - Branches with recent activity
   - Uncommitted changes
   - Recent error patterns in logs (if available)

4. **Read design references** and complete creative brief.

5. **Generate HTML** with these sections:
   - **Project Identity**: Name, purpose, tech stack, key metrics (lines of code, contributors)
   - **Architecture Map**: Mermaid diagram of major components and their relationships
   - **Recent Activity**: Timeline of recent commits, grouped by theme
   - **Key Files**: Quick-reference table of the most important files and what they do
   - **Open Threads**: TODOs, active branches, unfinished work
   - **Getting Started**: How to run, test, and deploy (extracted from README/config)

6. **Write** to `~/.visualize/YYYY-MM-DD/project-recap/index.html` and open in browser.

## Quality Checklist

- Architecture diagram reflects actual code structure (verified by reading files)
- Recent activity is grouped by theme, not just chronological
- Key files list is curated (10-15 most important), not exhaustive
- Getting started instructions actually work (verified against config files)

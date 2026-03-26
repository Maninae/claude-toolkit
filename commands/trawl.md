---
description: Deep context exploration of the codebase based on current task
---

# /trawl - Deep Context Hunt

When the user runs `/trawl`, perform an exhaustive exploration of the codebase to gather all relevant context for the current task or conversation topic.

## What This Workflow Does

Systematically explores the project to build a comprehensive mental model, focusing on areas relevant to what's being discussed.

## Steps

### 1. Identify Keywords from Current Context
Based on the conversation so far, extract 3-7 keywords that represent:
- The main topic/feature being discussed
- Related components or systems
- Technologies or patterns involved

### 2. Search Session History
// turbo
```bash
grep -ri "<keyword1>\|<keyword2>\|<keyword3>" .claude/history/*/BRIEF.md 2>/dev/null | head -20
```

Read the full `session.md` for the 2-3 most relevant matches.

### 3. Search Technical Docs
// turbo
```bash
grep -ri "<keywords>" .claude/techdocs/ .claude/rules/ .claude/skills/ 2>/dev/null | head -20
```

Read any docs that appear highly relevant.

### 4. Search Codebase
// turbo
```bash
# Find relevant source files (adjust patterns for your project)
grep -rn "<keywords>" src/ --include="*.py" --include="*.js" --include="*.ts" 2>/dev/null | head -30
```

### 5. Explore Directory Structure
// turbo
```bash
# List key directories related to the task
ls -la <relevant_dir>/
```

### 6. View Key Files
For each highly relevant file discovered:
- View the file outline first (`view_file_outline`)
- If needed, read specific functions or sections
- Prioritize: core logic > utilities > tests

### 7. Check Future Features
// turbo
```bash
ls .claude/future_features/ | head -10
```

Skim any that relate to the current topic.

### 8. Synthesize Findings

After exploration, provide a summary:

```
## 🔍 Context Trawl Complete

### Keywords Searched
[list of keywords used]

### Relevant History Found
- [session] - [brief description]
- ...

### Key Files Discovered
| File | Relevance |
|------|-----------|
| path/to/file.py | [why it matters] |
| ... | ... |

### Architecture Understanding
[Brief summary of how the relevant pieces fit together]

### Ready to Proceed
[Confirmation that context is loaded, or questions if anything is unclear]
```

## When to Use

- Starting work on an unfamiliar part of the codebase
- Before making significant changes
- When the user asks "how does X work?"
- When debugging something that touches multiple systems
- After `/resume` if more context is needed

## Tips

- Don't read everything verbatim - use outlines and strategic sampling
- Focus on understanding *relationships* between components
- Note any patterns or conventions discovered
- If context gets too large, summarize and move on
- Ask clarifying questions if the task scope is unclear

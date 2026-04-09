---
name: plan-review
description: Compare an implementation plan against the codebase with risk assessment and dependency analysis. Use before starting work on a plan to validate feasibility.
argument-hint: [path to plan file or "the current plan"]
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, AskUserQuestion, ToolSearch
---

# Plan Review

Generate a visual assessment of an implementation plan — comparing it against the actual codebase to identify risks, dependencies, and feasibility issues.

## Invocation

```
/plan-review                      # Review the current conversation's plan
/plan-review ./plan.md            # Review a plan file
/plan-review --slides             # Output as slide deck
```

## Workflow

1. **Load the plan**:
   - From argument path, or from conversation context (look for task lists, plans, specs)
   - Extract: goals, steps, files to modify, new files to create, dependencies

2. **Cross-reference the codebase**:
   - For each file mentioned in the plan, check if it exists and read its current state
   - Identify dependencies the plan doesn't mention (imports, shared state, tests)
   - Check for conflicts with recent changes (`git log --oneline -20`)
   - Estimate complexity per step based on actual code structure

3. **Risk assessment**:
   - **Missing steps**: things the plan should do but doesn't mention
   - **Wrong assumptions**: files that don't exist, APIs that have changed, outdated patterns
   - **Dependency risks**: shared code that other systems depend on
   - **Test gaps**: changes without corresponding test updates
   - **Ordering issues**: steps that depend on other steps but aren't sequenced correctly

4. **Read design references** and complete creative brief.

5. **Generate HTML** with these sections:
   - **Plan Overview**: Summary of what the plan proposes
   - **Codebase Map**: Mermaid diagram showing affected files/modules and their relationships
   - **Step-by-Step Analysis**: Each plan step with feasibility rating (green/amber/red) and notes
   - **Risk Register**: Table of identified risks with severity and mitigation suggestions
   - **Missing Steps**: Suggested additions to the plan
   - **Verdict**: Overall feasibility assessment with confidence level

6. **Write** to `~/.visualize/YYYY-MM-DD/plan-review/index.html` and open in browser.

## Quality Checklist

- Every risk is grounded in actual code (file paths, line numbers, function names)
- Feasibility ratings are specific, not hand-wavy
- The codebase map accurately reflects the current state (not imagined)
- Missing steps are actionable (not just "add tests")

---
description: comprehensive documentation overhaul of a codebase by systematically creating deeply researched READMEs for every directory
---

# Documentation Spree Workflow

This workflow guides you through systematically documenting a codebase by creating "uber comprehensive" `README.md` files for every logical component. The goal is to make the codebase strictly self-documenting so any developer can ramp up instantly.

## 1. Analyze and Structure

First, visualize the codebase layout to understand the scale and logical boundaries.

```bash
# Get a high-level view (adjust depth as needed)
tree -L 6 -d
```

## 2. Plan and Track

Identify the logical "subtrees" that need documentation. A subtree is usually a directory acting as a distinct module, layer, or interface (e.g., `tests/`, `utils/`, `core/`, `api/`).

**Create a Progress Tracker** in your `session.md` (or the current plan file):

```markdown
## Documentation Plan
- [ ] **Root** (Project overview, architecture)
- [ ] **Core** (`internal/core`)
- [ ] **API** (`internal/api`)
- [ ] **Utilities** (`pkg/utils`)
...and so on for every target directory.
```

**Rule:** Do not proceed without this tracker. It is your roadmap.

## 3. Deep Dive Read (The "No Shortcuts" Rule)

For the current target subtree: **Read EVERY file.**

Do not skim. Do not guess. You must obtain a complete, robust understanding of:
- The component's purpose and role in the system.
- Every module, class, and function.
- How it interfaces with other parts of the system.
- Edge cases and design decisions.

*Tip: Use `list_dir` to get the file list, then `view_file` on chunks of files until you have read the entire content of that directory.*

## 4. Synthesis (The "Uber README")

Write a `README.md` in the target directory (e.g., `pkg/utils/README.md`).

**Requirements for the README:**
- **Comprehensive**: Don't hold back. detailed explanation > brevity.
- **Roles & Responsibilities**: What is this directory for?
- **Architecture**: How does it work? Diagrams (mermaid) are welcome if helpful.
- **File Breakdown**: A table or list explaining what each relevant file does.
- **Usage**: Examples of how to use the code in this directory.

**Updates**:
- If a `README.md` already exists, AUGLMENT it. Do not destroy valuable history, but aggressively improve and expand it.
- If you find deprecated code or confusion during step 3, document it here.

## 5. Iterate

1.  Mark the current item as **[x] Done** in your Progress Tracker.
2.  Pick the next item.
3.  Repeat Steps 3 & 4.
4.  Continue until the entire Progress Tracker is complete.

## 6. Final Review

Once all subtrees are documented:
1.  Read the **Root README**. Does it link to these new sub-READMEs?
    *   *Action: Update the Root README to index the new documentation.*
2.  Verify consistency. Did you use the same terminology across all docs?
3.  Create a final summary in your session history.

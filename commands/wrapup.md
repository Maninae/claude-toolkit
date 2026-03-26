---
description: Wrap up session with comprehensive summary in history directory
---

# Session Wrapup Workflow

Use this at the end of a session to document everything that happened.

## Steps

1. **Identify or create the session directory**
   - Check if a session directory exists in `.claude/history/` for today
   - If not, create one: `.claude/history/YYYYMMDD-HHMMSS_<description>/`
   - Use "session" as default description if none provided

2. **Write the session summary to `session.md`**
   
   Include these sections (summarize, don't copy verbatim):
   
   ```markdown
   # Session Summary: [Brief Title]
   
   **Date**: [Date range]
   **Focus**: [Main topics]
   
   ---
   
   ## What We Built
   [Key features/components created or modified]
   
   ## Key Refactoring
   [Code organization changes, file moves, deletions]
   
   ## Important Decisions
   [Architecture decisions, design philosophy choices]
   
   ## User Info Learned
   [Any personal info, preferences, or context gathered]
   
   ## Files Created/Modified
   [List of significant file changes]
   
   ## Known Issues / Bugs Found
   [Any problems identified but not yet fixed]

   ## Other Conversational Tidbits
   [Things you talked about together, that's not strictly project-related]
   
   ## Next Steps
   [Checklist of what to do in future sessions]
   
   ## How to Resume
   [Commands to run, files to read]
   ```

3. **Create the session brief (`BRIEF.md`)**
   
   Create a 1-2 sentence `BRIEF.md` in the same session directory that signals what information an agent would get by reading the full `session.md`. Include relevant keywords.
   
   ```markdown
   # Brief
   
   [1-2 sentence description of what was accomplished and learned]
   
   **Keywords:** [comma-separated keywords for searchability]
   ```
   
   Example:
   ```markdown
   # Brief
   
   Built complete iOS foundation: FastAPI backend + SwiftUI app with TOTK design system. Implemented chat, state browser, and check-in views.
   
   **Keywords:** ios, fastapi, swiftui, backend, design-system, complete-implementation
   ```

4. **Update any related plans or reviews**
   - If there's an `implementation_plan.md`, update completion status
   - If there's an `architecture_review.md`, update with any new findings

5. **Confirm with user**
   - Tell the user where the summary was saved
   - Remind them how to resume next session

## Notes

- Be concise but comprehensive
- Summarize conversations, don't quote everything
- Focus on what a future AI assistant needs to continue the work
- Include any environment setup or gotchas discovered

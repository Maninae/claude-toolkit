# Archetype: Session Summary

## Communication Goal

Capture and crystallize a conversation or work session into a scannable reference. The viewer should be able to reconstruct what happened, what was decided, and what comes next — without re-reading the full conversation.

## Detection Signals

"summary", "recap", "worklog", "meeting notes", "what we discussed", "session notes", "summarize our conversation"

## Layout DNA

- **Structure**: Hero + Flow — single column, scrolling narrative
- **Density**: MEDIUM — readable paragraphs interspersed with structured elements
- **Sections**: Timeline-ordered with clear section breaks
- **Typography**: Readable body (1rem-1.1rem), generous line height (1.7), clear headings
- **Max width**: 65ch for prose sections, full width for tables/code

## Required Sections

| Section | Content | Priority |
|---------|---------|----------|
| TL;DR | 2-3 sentence overview of the entire session | MUST |
| Key Decisions | Bulleted list of decisions made with rationale | MUST |
| Topics Discussed | Grouped by theme, with brief summaries | MUST |
| Action Items | Who does what by when — table or checklist format | MUST |
| Open Questions | Unresolved items flagged for follow-up | IF ANY |
| Code Changes | Files modified with brief descriptions | IF CODE SESSION |
| Resources | Links, files, and references mentioned | IF ANY |

## Flavor Seeds

- **Meeting Minutes**: Clean, formal, serif headings, subtle blue accent. Think professional notes.
- **Dev Log**: Monospace headings, dark theme, code-block styling throughout. Think engineering notebook.
- **Casual Recap**: Warm palette, friendly sans-serif, relaxed spacing. Think team Slack post made beautiful.
- **Executive Brief**: Ultra-concise, metric-forward, structured. Think board meeting summary.

## Technical Requirements

- Collapsible sections for long topics (details/summary HTML)
- Timestamp markers for when topics occurred (if available)
- Copy-to-clipboard buttons on action items and code blocks
- Anchor links in the hamburger nav for quick jumps
- Print-friendly: clean single-column layout when printed

## Anti-Patterns

- Including everything discussed (summarize, don't transcribe)
- Missing action items (every summary should end with "what's next")
- Wall-of-text paragraphs without structure (use bullets, tables, headings)
- Burying the most important decisions deep in the page
- Editorializing or adding opinions not present in the original session

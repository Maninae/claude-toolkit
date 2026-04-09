---
name: slides
description: Generate a magazine-quality slide deck on any topic. Creates an HTML presentation with keyboard navigation, transitions, and fullscreen support.
argument-hint: <topic or content to present>
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, AskUserQuestion, ToolSearch
---

# Slides

Generate a self-contained HTML slide deck with keyboard navigation, smooth transitions, and fullscreen support.

## Invocation

```
/slides our Q4 results
/slides how the auth system works
/slides onboarding guide for new engineers
/slides --from ./notes.md        # Build slides from a file
```

## Workflow

1. **Parse content source**:
   - Natural language topic → gather from conversation context and codebase
   - `--from <path>` → read the file and structure into slides
   - Determine audience and appropriate depth

2. **Plan the deck**:
   - Outline slides: title → context → core content (3-7 slides) → summary
   - Each slide makes ONE point (max 40 words per slide)
   - Identify where diagrams, code, or data would strengthen a slide

3. **Read design references**:
   - Read `references/_principles.md` for creative brief and anti-slop rules
   - Read `references/presentation-deck.md` for the archetype brief
   - Complete the creative brief — pick a flavor seed that fits the content

4. **Generate HTML**:
   - Full-viewport slides (`100vh`, `100vw` per slide)
   - Keyboard navigation: Arrow keys, Space, Enter, F for fullscreen
   - Touch/swipe support for mobile
   - Progress bar (thin, top of viewport, accent color)
   - Slide counter ("3 / 12")
   - Slide transitions: crossfade (300ms, ease-out)
   - Responsive: readable on phone through projector

5. **Write** to `~/.visualize/YYYY-MM-DD/slides-<slug>/index.html` and open in browser.

## Slide Design Rules

- Title slide: large heading + subtitle, no bullet points
- Content slides: heading + 3 bullets max, or heading + visual
- Code slides: heading + single code block, large font
- Data slides: heading + one chart, no surrounding text
- Quote slides: large italic text + attribution
- Never: walls of text, more than 5 bullets, font smaller than 1.2rem

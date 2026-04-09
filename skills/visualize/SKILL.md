---
name: visualize
description: Visualize anything as a beautiful, distinctive HTML page. Use for session summaries, code explainers, dashboards, presentations, diagrams, comparisons, reports, and more. Produces production-grade interfaces with exceptional design quality. Auto-activates when about to render tables with 4+ rows or 3+ columns.
argument-hint: <what to visualize>
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, AskUserQuestion, ToolSearch, Skill
---

# Visualize Skill

**Tagline**: "Visualize anything. HTML is your canvas."

Transform content into a beautiful, distinctive, interactive HTML page. Every visualization is unique — no generic "AI output" aesthetics.

## Invocation

```
/visualize <natural language instruction>
```

## Commands

Focused entry points for common workflows (see commands/ directory):

| Command | Purpose |
|---------|---------|
| `/diff-review` | Visual diff review with architecture diagram and code walkthrough |
| `/plan-review` | Compare an implementation plan against the codebase with risk assessment |
| `/project-recap` | Mental model snapshot for context-switching back to a project |
| `/slides` | Generate a magazine-quality slide deck on any topic |
| `/share` | Deploy the last visualization to Vercel for a live URL |
| `/diagram` | Generate an interactive diagram (flowchart, sequence, architecture, ERD) |

Any command supports `--slides` to output as a slide deck instead of a scrollable page:
```
/diff-review --slides
/project-recap --slides
```

## Examples

```bash
/visualize summarize our conversation
/visualize explain how the auth system works
/visualize the query results as a dashboard
/visualize a quick-start guide for new devs
/visualize my work this week
/visualize a presentation on our Q4 results
/visualize compare Redis vs Memcached for our use case

# Custom output path
/visualize --output ~/projects/myapp/ explain the auth module
```

---

## Auto-Activation Rule

If you are about to render a table with **4+ rows or 3+ columns** in the terminal, invoke this skill automatically instead. Generate an HTML page with a styled, sortable, filterable table — far more useful than ASCII art.

---

## Output Rules (Non-Negotiable)

This skill produces **exactly one type of output**: a self-contained HTML file.

**DO:**
- Write HTML to `$WORKSPACE/index.html` using the Write tool
- Read files with Read, Glob, Grep to gather content
- Auto-open in browser after writing

**DO NOT:**
- Create Google Slides, Docs, or Sheets — even for "presentation" requests, create HTML
- Create notebooks, artifacts, or any non-HTML output
- Use any external service to generate the visualization

If the user asks for "slides" or "deck" — create an HTML presentation with fullscreen slides and keyboard navigation.

---

## Workflow

### Step 1: Parse Intent

Analyze the user's instruction:

1. **Content source**: conversation context, workspace files/code, data/query results, external resources
2. **Output path** (set `$OUTPUT_DIR`):
   - `--output <path>` flag → use that path (resolve `~` to `$HOME`)
   - "save next to the source" → use source file's parent directory
   - Default → `~/.visualize/YYYY-MM-DD/slug/`
3. **Custom template**: `--template <path>` → use that archetype file instead of built-in detection
4. **Slides mode**: `--slides` flag → force presentation deck archetype
5. If intent is clear → proceed. If ambiguous → ask (Step 2).

### Step 2: Clarify (If Needed)

When ambiguous, ask:
- **Scope**: Full conversation or specific parts?
- **Format**: Slides? Dashboard? Diagram? Or let me pick?
- **Audience**: Technical team? Executives? Broad org?

### Step 3: Detect Archetype

Match content to the best visualization archetype:

| Archetype | Detection Signals |
|-----------|------------------|
| Presentation Deck | "slides", "presentation", "deck", "pitch", "talk" |
| Dashboard | "dashboard", "status", "metrics", "KPIs" |
| Comparison Matrix | "compare", "comparison", "evaluation", "vs" |
| Session Summary | "summary", "recap", "worklog", "meeting notes" |
| Diagram | "diagram", "flowchart", "sequence", "architecture", "ERD", "graph" |
| Report | "report", "analysis", "experiment", "A/B test", "results", "debrief" |
| Diff Review | "diff", "review", "my changes", "what changed" |
| Project Roadmap | "roadmap", "plan", "milestones", "phases" |
| FAQ / Reference | "FAQ", "reference", "guide", "runbook", "how-to" |
| Visual | "infographic", "visual", "chart", "one-pager" |
| Freestyle | None of the above match well |

### Step 4: Load Design References

Read reference files from the `references/` directory adjacent to this SKILL.md:

1. **Always** read `references/_principles.md` — creative brief template, anti-slop rules, typography/color/motion guidance
2. If `$CUSTOM_TEMPLATE` is set → read that file instead of a built-in archetype
3. Otherwise → read the matched archetype brief from `references/`
4. Optionally read `references/components.md` for building blocks (metric cards, callouts, timelines)

### Step 5: Complete the Creative Brief

Before writing ANY HTML, complete the brief (from `_principles.md`):

1. **PURPOSE** — What is this communicating? Who is the audience?
2. **METAPHOR** — What visual world does this belong to? Not "dashboard" but "mission control room."
3. **TYPOGRAPHY** — Name two specific Google Fonts. Explain WHY they fit this content's emotional register.
4. **PALETTE** — Name ONE dominant hue and why it matches the mood. Then pick an accent.
5. **SIGNATURE** — What ONE thing will make someone remember this visualization?
6. **COMPOSITION** — Dense or spacious? Scrolling or fixed? Centered or full-bleed? Grid or organic?

This brief is your contract. Every design decision must trace back to it.

### Step 6: Gather Content

Based on the instruction, gather content from files, conversation, APIs, or codebase analysis.

### Step 7: Generate HTML

1. **Create workspace**:
   ```
   SLUG = kebab-case from instruction
   WORKSPACE = $OUTPUT_DIR or ~/.visualize/YYYY-MM-DD/$SLUG/
   ```

2. **Compose HTML** — design from scratch, guided by the creative brief:
   - Clean `<!DOCTYPE html>` — no frameworks, no build steps
   - Load Google Fonts matching chosen typography via `<link>` tag
   - CSS custom properties contract: `:root` = light mode, `body.dark-mode` = dark mode
   - Include entrance animations (page load reveals) and scroll-triggered animations
   - CDN libraries ONLY when needed (Mermaid for diagrams, Chart.js for charts, D3 for data viz)
   - When loading CDN libs, include `integrity` and `crossorigin="anonymous"` attributes (SRI)
   - Make it distinctive — if it looks like generic AI output, start over

3. **UI Chrome** (include in every visualization):
   - Dark/light mode toggle (top-right, respects `prefers-color-scheme`)
   - Fullscreen button
   - Save-as-image button (uses `html2canvas` from CDN, loaded on demand)
   - Hamburger menu for navigation on long pages
   - Responsive — works on mobile through desktop

4. **Theme polarity check**: `:root` MUST have light backgrounds; `.dark-mode` MUST have dark backgrounds. Never invert this.

5. **Write** the HTML to `$WORKSPACE/index.html`

### Step 8: Open & Report

```bash
open $WORKSPACE/index.html
```

Report:
- Local file path
- What was visualized and the archetype chosen
- Remind user they can run `/share` to deploy to a live URL

---

## Quality Bar

Every output must feel like it was designed by a senior product designer, not generated by AI. Test against these questions:

1. Would I be proud to share this in a team Slack channel?
2. Does it have a clear visual hierarchy — can I scan it in 3 seconds?
3. Is there ONE distinctive design choice that makes it memorable?
4. Does the dark mode look intentionally designed, not just inverted?
5. Are animations subtle and purposeful, not decorative?

If any answer is "no" — revise before outputting.

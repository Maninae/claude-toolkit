---
name: readme-writer
description: Write eye-catching, tight technical READMEs for GitHub repositories. Use when creating or rewriting a repo's README.md.
---

# README Writer

Write READMEs that make people stop scrolling and actually read. Every line earns its place.

## Process

1. **Understand the project** — read the codebase, config files, and any existing docs to grasp what it does, who it's for, and what makes it different.
2. **Draft the README** following the structure and rules below.
3. **Apply the write-like-human skill** if available — cut AI-sounding prose.
4. **Self-review** — read it as a stranger landing on the repo for the first time. Does the first screen answer "what is this and why should I care?"

---

## Structure (top-to-bottom, in order)

### 1. Hero Section
- Centered: logo/banner if the project has one, otherwise skip — don't force it
- Project name as `# heading`
- One-line description: what it does, not what it is. "Sync Claude Code skills across machines" not "A toolkit for managing Claude Code configurations"
- Badges underneath: build status, version, license, platform — 3-5 max, grouped with `<p align="center">`

### 2. Value Pitch (2-3 sentences max)
- What problem does this solve?
- Why would someone choose this over alternatives?
- No jargon. A stranger should understand this paragraph.

### 3. Visual Proof (if applicable)
- Screenshot, GIF, or terminal recording showing the tool in action
- One hero image is worth more than paragraphs of description
- For CLI tools: a code block showing real terminal output works great

### 4. Quick Start
- Copy-paste install + first command
- Under 4 lines of shell. Get someone from zero to working in 30 seconds.
- If setup has OS-specific steps, use a table — not separate sections

### 5. Feature Overview
- Table or bullet list — scannable, not prose
- Each row: feature name + one-line description
- If comparing categories, use a table with columns

### 6. Usage / Examples
- Real code snippets showing the 2-3 most common patterns
- Syntax-highlighted, copy-pasteable
- Show, don't tell: a code example beats a feature description

### 7. How It Works (if non-obvious)
- ASCII diagram or short explanation of architecture
- Keep it under 20 lines — link to docs/ for deep dives
- `<details>` collapsible for anything verbose

### 8. Configuration / API (if needed)
- Table format for options: name, type, default, description
- Link to full docs if the reference is long

### 9. Contributing + License
- Brief. At the bottom. Link to CONTRIBUTING.md if it exists.

---

## Writing Rules

- **Lead with "what" not "how"**: first sentence = what the project does
- **Active voice, present tense**: "Generates reports" not "Reports can be generated"
- **One idea per section**: don't combine install with configuration
- **Under 500 lines**: link to docs/ for anything deeper
- **No marketing language**: never write "blazing fast", "revolutionary", "game-changing", "seamlessly"

## Formatting Rules

- `<p align="center">` for centered hero sections
- Tables over prose for anything with 2+ items and distinguishing properties
- Horizontal rules (`---`) to visually separate major sections
- Syntax-highlighted code blocks for all commands and code
- `<details><summary>` for content that's useful but not essential on first read
- `<kbd>` tags for keyboard shortcuts
- Emoji as section markers: sparingly, one per heading max, only if the project's tone supports it

## Anti-Patterns — Never Do These

- Badge spam (10+ badges nobody reads)
- Table of Contents for a short README (under 200 lines doesn't need one)
- Repeating the project name in every section header
- An "About" section that restates the one-liner
- Giant prerequisite lists before showing value
- Wall of text with no visual breaks
- Dramatic fragment cadence: "X is happening. A big one." — that's an AI tell
- Grandiose framing: "the tool that changes everything"

## Tone

Write like a senior engineer explaining their project to a peer at a conference. Direct, technical, a little personality — not corporate, not breathless. The README should feel like it was written by someone who built the thing and is proud of it but doesn't need to oversell it.

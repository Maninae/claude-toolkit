# Archetype: Report

## Communication Goal

Present findings, analysis, or results in a structured, authoritative format. Reports answer "what happened?", "what did we learn?", and "what should we do next?" They combine narrative with evidence (data, charts, code) to support conclusions.

## Detection Signals

"report", "analysis", "experiment", "A/B test", "results", "findings", "debrief", "weekly update", "work digest", "post-mortem", "incident report"

## Layout DNA

- **Structure**: Hero + Flow — long-form scrolling with clear section hierarchy
- **Density**: MEDIUM — prose-heavy but broken up with charts, tables, and callouts
- **Typography**: Readable (1rem body, 1.7 line height, 65ch max-width for prose)
- **Sections**: Numbered or clearly titled, with anchor navigation
- **Evidence blocks**: Charts, tables, and code blocks interspersed at full width

## Required Sections

| Section | Content | Priority |
|---------|---------|----------|
| Executive Summary | 3-5 sentences covering the key finding and recommendation | MUST |
| Background / Context | Why this analysis was done, what question it answers | MUST |
| Methodology | How data was gathered, what was measured | IF EXPERIMENT |
| Findings | Data, charts, tables supporting the analysis | MUST |
| Discussion | Interpretation of findings, caveats, limitations | SHOULD |
| Recommendations | Concrete next steps based on findings | MUST |
| Appendix | Raw data, additional charts, detailed tables | OPTIONAL |

## Report Subtypes

| Subtype | Focus | Special Elements |
|---------|-------|-----------------|
| Experiment Report | A/B test results, statistical significance | Confidence intervals, p-values, sample sizes |
| Incident Post-Mortem | What broke, why, how it was fixed | Timeline, root cause diagram, action items |
| Weekly/Monthly Digest | Work completed, metrics, highlights | Metric cards, progress bars, changelog |
| Technical Analysis | Deep dive into a technical topic | Code blocks, architecture diagrams, benchmarks |

## Flavor Seeds

- **Academic Paper**: Serif headings, numbered sections, figure captions. Think research paper meets web.
- **Consulting Deck**: Clean sans-serif, blue/gray palette, structured callout boxes. Think McKinsey one-pager.
- **Engineering Log**: Monospace accents, dark code blocks, timeline markers. Think detailed incident report.
- **Editorial**: Large serif headings, generous whitespace, pull quotes. Think data journalism.

## Technical Requirements

- Table of contents generated from headings (in hamburger nav)
- Charts with clear titles, axis labels, and legends
- Callout boxes for key findings (colored left border, background tint)
- Footnotes or inline annotations for methodology details
- Print-friendly: clean layout, no fixed elements, page breaks before sections
- Code blocks with syntax highlighting (Prism.js) if code is referenced

## Anti-Patterns

- Burying the conclusion at the end (lead with the finding, explain after)
- Charts without context (every chart needs a one-sentence interpretation)
- Mixing findings with recommendations (separate "what happened" from "what to do")
- Overly long reports without an executive summary
- Data dumps without narrative (tables need interpretation)

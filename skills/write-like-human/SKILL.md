---
name: write-like-human
description: Optimize prose for human readability in educational/technical writing. Use when the user asks to tighten writing, remove AI-sounding language, or make technical content more human and readable.
argument-hint: [file or directory to edit]
---

# Write Like Human: Prose Optimization for Educational Content

Surgically edit prose to sound like a kind, engaging college professor — narrative, clear, technically precise — while cutting genuinely empty words.

The target audience is undergraduate or graduate students learning technical concepts for the first time.

## Decision Rule

For every clause, ask: does this add ANY new perspective, semantic abstraction, metaphor, or learning aid? If yes, keep it. Only cut what is genuinely empty. When in doubt, leave it alone.

## CUT these patterns:

- **Empty throat-clearers**: "At its core,", "head-on", "turn out to be even", "It is worth noting that"
- **Filler hedging**: "It is important to note that", "arguably an essential component of X itself", "The remarkable property of X is that"
- **Obvious connectors**: "This arises, for instance," / "In such cases," — when the list or surrounding context already makes the connection obvious
- **Redundant restatements** that add zero new angle after a formula or definition already said the same thing
- **Over-narration of math**: Don't re-explain every symbol in a formula when definitions were already given
- **Dramatic fragment cadence**: "X is happening. A big one." / "And it shows." — the short-sentence mic-drop is a GPT tell
- **Staccato parallel fragments**: "But X are Y. A are B." — back-to-back short sentences with identical structure reads as generated
- **Grandiose framing**: "the book that started it all", "the paper that changed everything" — real people don't canonize casually

## KEEP these patterns:

- **Narrative transitions and segues**: "Throughout this course we have studied..." — these orient the student and create a collegiate, professorial voice
- **Flow conjunctions**: "while", "but", natural connectors — prefer these over jarring semicolons or terse fragments
- **Technically precise language**: "game-theoretic settings" not "games", "state-action space" not "state-action pairs" — don't collapse distinctions for brevity
- **Complementary clauses hitting different facets**: e.g. "sample-efficient *and* easier to optimize" — both matter, even if they seem similar to an LLM. Students need both angles to build intuition
- **Metaphors and storytelling touches**: "The tension is real:" — human voice, not AI voice
- **Enumerations of prior concepts**: Students are not perfect recallers. Listing what they've already learned helps them map old concepts to new ones

## RESTRUCTURE for visual clarity:

- When a sentence enumerates 3+ methods or concepts inline, break into a bullet list — scannable, aids recall
- Long paragraphs covering distinct sub-points: split with newlines or bullet points
- These are low-cost, high-impact edits that don't change any words

## Rules:

- Never delete formulas, definitions, theorems, algorithm boxes, or examples
- Never change section headings or structural markup
- Never add new content — only trim and restructure existing prose
- Keep technical precision — don't sacrifice accuracy for brevity
- Keep the narrative, professorial voice — engaging, not terse
- The goal is a ~10-20% reduction in word count, not a rewrite

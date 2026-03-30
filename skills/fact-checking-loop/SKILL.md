---
name: fact-checking-loop
description: "Use when verifying factual claims in educational content, documentation, or technical writing. Producer extracts claims, auditor verifies against online sources, lead applies fixes."
---

# Fact-Checking Loop

A verified pipeline for checking factual claims in educational or technical content against authoritative sources.

**References:** `generalized-loop-patterns` for shared principles.

## When to Use

- Reviewing lecture notes, course content, or technical documentation for accuracy
- Verifying paper attributions (author, year, venue)
- Checking numerical claims (dimensions, ratios, parameter counts)
- Validating math formulas against source papers
- Confirming historical claims and timelines

## The Pipeline

```
Builder (extractor)  →  claims per file  →  Auditor (verifier)
                                                  ↓
                                            Lead (applies fixes)
```

### Step 1: Setup

Spawn two agents:
- **Builder** (general-purpose, bypassPermissions) — reads files, extracts claims
- **Auditor** (general-purpose, bypassPermissions) — needs WebSearch + WebFetch for verification

Tell the auditor: "Report findings to team-lead only. Do not message the builder."

### Step 2: Extraction

Builder reads each file and extracts ALL factual claims as a numbered bullet list. Focus on:

- **Paper attributions:** "X et al. (year) proposed Y"
- **Math formulas:** equations and their stated properties
- **Numerical facts:** dimensions, step counts, compression ratios, parameter counts
- **Historical claims:** timelines, who-did-what-first
- **Technical properties:** convergence, complexity, what works/doesn't

**Format:** Numbered list with enough context to verify independently.

**Batch size:** One file at a time. Builder sends each batch to auditor via SendMessage, fire-and-forget — no waiting for responses.

### Step 3: Verification

Auditor receives each batch and for each claim:
1. WebSearch for authoritative sources (arxiv, official papers, textbooks)
2. Verify the specific claim against the source
3. Flag anything incorrect, imprecise, or misleading
4. For flagged items: provide the correct information with source URL/citation

**Report format to lead:**
```
## [File] Fact-Check Results

**N claims checked. M issues found.**

### ISSUES FOUND
- Claim #X — [quote] — ERROR/IMPRECISE
  - What's wrong: ...
  - Correct info: ... (source: ...)
  - Recommended fix: ...

### ALL CORRECT
- Claim #Y — [brief description]. **Correct.** [verification note]
```

### Step 4: Fix Application

Lead applies fixes directly as auditor reports come in:
1. Grep for the incorrect text
2. Read the file
3. Edit with the correction
4. Track fixes for batch commit

**Delegate to builder only for:** Complex rewrites that need surrounding context adjusted.

**Commit strategy:** Batch all fixes from the full pipeline into one commit, or commit per-file if fixes are substantial.

## Common Issue Categories

From real usage (277 claims across 13 lectures):

| Category | Example | Frequency |
|----------|---------|-----------|
| **Citation year** | arXiv date vs conference year (2013 vs 2014) | Common |
| **Attribution** | Wrong author for a technique | Rare but critical |
| **Arithmetic** | "64x compression" when math gives 48x | Occasional |
| **Conflation** | Claiming model X uses technique Y when it uses Z | Occasional |
| **Disambiguation** | Two different "Song et al." papers by different authors | Rare |
| **Divisibility** | "28 not divisible by 4" (it is: 28/4=7) | Rare |

## Parallelization

For large corpora, split the auditor:

```
Builder → all batches → Auditor-1 (files 1-5)
                       → Auditor-2 (files 6-10)
                       → Auditor-3 (files 11-13)
```

Each auditor reports to lead independently. No coordination needed between auditors since files are independent.

## Metrics (baseline)

| Corpus | Claims | Extraction Time | Verification Time | Issues Found |
|--------|--------|-----------------|-------------------|-------------|
| 13 HTML lectures | 277 | ~5 min | ~15 min | 7 (2.5%) |

**Bottleneck:** Verification (WebSearch per claim). Extraction is 3x faster. Design for this asymmetry.

## Checklist

- [ ] Spawn builder + auditor (both general-purpose, bypassPermissions)
- [ ] Tell auditor: report to lead only, never message builder
- [ ] Builder extracts per-file, fire-and-forget to auditor
- [ ] Lead monitors auditor reports and applies fixes directly
- [ ] Commit all fixes when pipeline completes
- [ ] Shut down agents when done

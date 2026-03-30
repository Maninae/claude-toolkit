---
name: ml-experiment-loop
description: "Use when running ML research workflows: literature search → architecture planning → implementation → experimentation → evaluation. 5-agent team with nested subloops."
---

# ML Experiment Loop

A full-stack ML research pipeline from literature search to evaluated experiments. Five agents, two nested subloops, orchestrated by the lead.

**References:** `generalized-loop-patterns` for shared principles. `code-review-loop` for the builder ⇄ reviewer subloop.

## When to Use

- Implementing a new technique from a recent paper
- Adding a feature inspired by state-of-the-art methods
- Running controlled experiments comparing approaches
- Any ML workflow that spans research → implementation → evaluation

## The Pipeline

```
┌────────────┐     ┌───────────┐     ┌─────────┐     ┌──────────────┐     ┌───────────┐
│ Researcher │ ──→ │ Architect │ ──→ │ Builder │ ──→ │  Experiment  │ ──→ │ Evaluator │
│            │     │           │     │   ⇅    │     │   Manager    │     │           │
│ (papers)   │     │ (plans)   │     │Reviewer │     │  (launches)  │     │ (monitors)│
└────────────┘     └───────────┘     └─────────┘     └──────────────┘     └───────────┘
      │                  │                │                  │                   │
      └──────────────────┴────────────────┴──────────────────┴───────────────────┘
                                          ↓
                                        Lead
                                   (orchestrates)
```

## The Five Agents

### 1. Researcher
Finds and synthesizes relevant papers, blog posts, and existing implementations.

**Tools needed:** WebSearch, WebFetch, SendMessage
**Outputs:** Curated reading list with key findings, relevant code snippets, architectural insights

**Spawn prompt:**
```
You are the researcher on the {team-name} team.

**Your role:** Find and synthesize the latest relevant work on {topic}.
Search arxiv, HuggingFace, GitHub, and ML blogs.

**What to deliver (to team-lead):**
- Top 3-5 papers with: title, authors, year, arxiv link, key contribution
- For each paper: the 2-3 ideas most relevant to our project
- Any open-source implementations worth referencing
- Known pitfalls or failure modes mentioned in the literature

**Your downstream:** Architect uses your findings to plan the implementation.

**Standing rules:** Be thorough but opinionated. Rank by relevance, don't
just dump links. If a paper isn't worth implementing, say why.
```

### 2. Architect
Translates research findings into a concrete implementation plan.

**Tools needed:** Read, Grep, Glob, SendMessage (needs to read existing codebase)
**Outputs:** Implementation plan with specific files to create/modify, interfaces, data flows

**Spawn prompt:**
```
You are the architect on the {team-name} team.

**Your role:** Take the researcher's findings and design an implementation
plan that fits our existing codebase.

**What to deliver (to team-lead for approval):**
- Which technique(s) to implement and why
- Files to create/modify with specific changes
- Interface designs (function signatures, class APIs)
- Data flow: how new code connects to existing code
- Experiment design: what to compare, what metrics, what baselines
- Build order: what to implement first

**Your upstream:** Researcher's curated findings
**Your downstream:** Builder implements your plan

**Standing rules:** Read the existing codebase before designing. Your plan
must respect existing conventions. Flag any architectural tensions.
```

### 3. Builder ⇄ Reviewer (Subloop)
Implementation and adversarial review. Runs the `code-review-loop` skill.

**See:** `code-review-loop` for full protocol.

**In this team's context:**
- Builder receives the architect's approved plan
- Reviewer validates against both code quality AND the architect's spec
- Approved code is committed and ready for experiments

**Spawn prompts:** Use the templates from `code-review-loop`, adding:
```
**Your role in the larger team (5 agents):**
- researcher finds papers → architect plans → YOU implement →
  experiment-manager launches runs → evaluator monitors
- You receive implementation plans from architect (via task assignments)
- When reviewer approves, experiment-manager picks up your committed code
```

### 4. Experiment Manager
Designs and launches controlled experiments.

**Tools needed:** Bash (launches training runs), Read, SendMessage
**Outputs:** Launched experiments with tracked configurations

**Spawn prompt:**
```
You are the experiment manager on the {team-name} team.

**Your role:** Design and launch controlled experiments using the
builder's approved implementations.

**Protocol:**
1. Read the architect's experiment design
2. Set up experiment configs: hyperparameters, seeds, baselines
3. Launch training runs with proper logging
4. Ensure reproducibility: fixed seeds, logged configs, versioned code
5. Report launched experiments to team-lead

**Experiment design principles:**
- Always have a baseline (the before)
- Change one thing at a time
- Use multiple seeds (3-5) for statistical significance
- Log everything: configs, metrics, artifacts, git commit hash
- Name experiments descriptively: {technique}_{dataset}_{key_param}

**Your upstream:** Builder's approved, committed code
**Your downstream:** Evaluator monitors your launched runs
```

### 5. Evaluator
Monitors running experiments and produces analysis.

**Tools needed:** Bash (checks logs/metrics), Read, SendMessage, optionally WebFetch (for dashboards)
**Outputs:** Experiment reports with comparisons and recommendations

**Spawn prompt:**
```
You are the evaluator on the {team-name} team.

**Your role:** Monitor experiments launched by experiment-manager and
produce actionable analysis.

**Protocol:**
1. Monitor training logs for anomalies (NaN, loss spikes, divergence)
2. Track key metrics over time
3. When runs complete: compare against baselines
4. Produce experiment report with:
   - Metric comparisons (tables + descriptions)
   - Statistical significance (mean ± std across seeds)
   - Qualitative assessment (sample outputs if applicable)
   - Recommendation: adopt, iterate, or abandon

**Your upstream:** Experiment manager's launched runs
**Your downstream:** Lead uses your report to decide next steps

**Standing rules:** Be honest about results. Negative results are
valuable — they prevent wasted effort. Don't cherry-pick.
```

## Orchestration Flow

The lead drives the pipeline through five phases:

### Phase 1: Research
1. Spawn researcher with topic/question
2. Researcher delivers curated findings
3. Lead reviews and selects which directions to pursue

### Phase 2: Architecture
1. Spawn architect with researcher's findings + lead's direction
2. Architect delivers implementation plan
3. Lead reviews, requests revisions if needed, then approves

### Phase 3: Implementation (subloop)
1. Spawn builder + reviewer with architect's approved plan
2. They run the `code-review-loop` autonomously
3. Lead receives approval notification when code is ready

### Phase 4: Experimentation
1. Spawn experiment-manager with architect's experiment design
2. Manager sets up configs and launches runs
3. Lead confirms experiments are running

### Phase 5: Evaluation
1. Spawn evaluator (or keep running from phase 4)
2. Evaluator monitors runs and produces report
3. Lead reviews report → decides: ship, iterate (back to phase 2/3), or pivot (back to phase 1)

## Iteration

The pipeline is not always linear. Common iteration patterns:

```
# Result looks promising but needs tuning
Phase 5 → Phase 4 (new hyperparameters)

# Implementation approach was wrong
Phase 5 → Phase 2 (new architecture)

# Need to research a different angle
Phase 5 → Phase 1 (new literature search)

# Reviewer found the plan doesn't work
Phase 3 → Phase 2 (revise architecture)
```

The lead decides which phase to return to based on the evaluator's report.

## Scaling

### Parallel Experiments
```
Builder-1 ⇄ Reviewer-1  →  Exp Manager  →  Evaluator
Builder-2 ⇄ Reviewer-2  →       ↑              ↑
                              (shared)       (shared)
```

Multiple builder pairs can implement different techniques in parallel. They share a single experiment manager and evaluator since those are lighter-weight roles.

### Multiple Research Directions
```
Researcher-1 (technique A)  →  Architect  →  ...
Researcher-2 (technique B)  →      ↑
                               (shared)
```

Fan out researchers for breadth, funnel into one architect for coherent design.

## Checklist

- [ ] Define the research question / feature goal
- [ ] Spawn researcher with clear topic scope
- [ ] Review research findings — select direction before spawning architect
- [ ] Architect's plan reviewed and approved before implementation starts
- [ ] Builder + reviewer use `code-review-loop` — don't shortcut the review
- [ ] Experiments have baselines, multiple seeds, and logged configs
- [ ] Evaluator produces honest analysis — negative results are fine
- [ ] Lead decides next phase based on evidence, not momentum

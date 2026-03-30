---
name: generalized-loop-patterns
description: "Shared principles for designing any multi-agent loop — routing, backpressure, anti-patterns, and the design checklist. Referenced by specific loop skills."
---

# Generalized Loop Patterns

Shared engineering principles for any multi-agent loop. Specific loop implementations (fact-checking, ML experiments, code review) live in their own skills and reference this one.

## Loop Anatomy

Every loop has the same five components:

```
┌─────────┐     ┌───────────┐     ┌─────────┐
│ Producer │ ──→ │ Processor │ ──→ │ Router  │
└─────────┘     └───────────┘     └────┬────┘
                                       │
                              ┌────────┴────────┐
                              ▼                  ▼
                        ┌──────────┐      ┌──────────┐
                        │ Applier  │      │   Lead   │
                        │ (agent)  │      │ (direct) │
                        └──────────┘      └──────────┘
```

1. **Producer** — generates work items (extracts claims, identifies files, creates test cases)
2. **Processor** — transforms/verifies each item (fact-checks, reviews, evaluates)
3. **Router** — decides where results go (always lead; sometimes also an applier)
4. **Applier** — acts on results (fixes code, updates configs, commits)
5. **Termination** — knows when the loop is done

## Loop Topologies

Not all loops are DAGs. Some require bidirectional communication:

```
# DAG (one-directional) — fact-checking, auditing
Builder → Auditor → Lead

# Bidirectional — code implementation + review
Builder ⇄ Reviewer → Lead
(Builder sends code, Reviewer sends feedback, Builder revises)

# Fan-out — parallel processing under pressure
Lead → Builder-1 ──→ Lead
     → Builder-2 ──→ Lead
     → Builder-3 ──→ Lead
```

**Backpressure rule:** When any agent's queue grows faster than it can process, spawn parallel instances (builder-1, builder-2). Monitor this by watching idle notifications — if an agent never goes idle, it's under pressure.

## Core Principles

### 1. Route to the Orchestrator
Results always flow to the lead. For DAG loops, never create producer ↔ consumer cycles. For bidirectional loops (builder ⇄ reviewer), the lead should still receive copies of results for visibility.

```
# WRONG — circular dependency
Builder → Auditor → Builder → Auditor ...

# RIGHT — star topology
Builder → Auditor → Lead → (Lead applies or delegates)
```

### 2. Fire-and-Forget Over Synchronization
The producer is almost always faster than the consumer. Let work queue up.

```
# WRONG — synchronized
Producer sends batch 1 → waits for "ready" → sends batch 2 ...

# RIGHT — fire-and-forget
Producer sends batch 1, 2, 3, 4... → Consumer processes at own pace
```

**Exception:** When later batches depend on earlier results.

### 3. Right-Size the Batch

| Batch Size | When to Use |
|-----------|-------------|
| Per-item | Interactive fixes, real-time feedback |
| Per-file | Most audit/fix loops — natural boundary |
| Per-module | Large projects with clear module boundaries |
| All-at-once | Only when consumer needs global context |

### 4. Lead Applies Small Fixes Directly
Don't round-trip through an agent for a one-line edit. Delegate only for complex multi-line rewrites or judgment calls.

### 5. Checkpoint Between Iterations
Every completed batch → commit and push. Prevents lost work, merge conflicts, and state confusion.

### 6. Match Agent Type to Required Tools

| Agent Type | Can Edit? | Can SendMessage? | Can WebSearch? | Best For |
|-----------|-----------|-----------------|---------------|----------|
| general-purpose | ✓ | ✓ | ✓ | Any loop participant |
| Explore | ✗ | ✗ | ✗ | Read-only research (returns at completion only) |
| Plan | ✗ | ✗ | ✗ | Architecture planning (returns at completion only) |

**Rule:** Any agent in a loop that needs to communicate mid-task must be general-purpose.

## Anti-Patterns

| Anti-Pattern | Symptom | Fix |
|-------------|---------|-----|
| **Circular routing** | Agents ping-ponging messages | Route to lead only |
| **Phantom handoffs** | Messages to agents that can't receive | Check agent type's tools |
| **Echo chamber** | Agent confirms "already done" repeatedly | Acknowledge once, move on |
| **Flood pattern** | Consumer context fills up | Batch by logical unit |
| **Zombie agents** | Finished agents still running | Shutdown when role complete |
| **Synchronized bottleneck** | Producer blocked on slow consumer | Fire-and-forget |

## Design Checklist

- [ ] **What's the loop?** One sentence: "X produces, Y processes, Z applies"
- [ ] **Producer:** Who? What format? How many batches?
- [ ] **Processor:** Who? Do they need WebSearch, Edit, SendMessage?
- [ ] **Routing:** Results go to lead only (unless specific reason otherwise)
- [ ] **Backpressure:** Fire-and-forget (default) or synchronized?
- [ ] **Batch size:** Per-file (default) or different?
- [ ] **Fix application:** Lead for small, builder for complex
- [ ] **Commits:** After each batch/task
- [ ] **Termination:** How do you know it's done?
- [ ] **Parallelism:** Can you split across multiple processors?
- [ ] **Agent types:** Does each agent have the tools it needs?

## Composing Loops

Complex workflows chain multiple loops. Each sub-loop follows the same principles. The lead connects them by feeding one loop's output as the next loop's input.

```
Example — ML Experiment Loop (future):
  Loop 1: Researcher  → finds papers    → Lead curates
  Loop 2: Architect   → plans features  → Lead approves
  Loop 3: Builder    ⇄ Reviewer         → Lead merges
  Loop 4: Exp Manager → launches runs   → Evaluator monitors
```

## Nested Loops & Subgroup Awareness

In larger teams (4+ agents), some agents form **subgroups** that run a specific sub-loop together. These agents need three layers of context:

### 1. Local Context (their subloop)
Point them to the relevant loop skill. "You and reviewer run the `code-review-loop` together."

### 2. Partner Context (who they collaborate with)
Introduce their counterpart by name and role. "Reviewer sends you feedback. You revise and resubmit until they approve."

### 3. Global Context (the larger team)
Explain where their subloop fits in the pipeline. "Your approved code gets picked up by experiment-manager downstream."

### Spawn Template

```
You are {role} on the {team-name} team.

**Your subloop:** You and "{partner}" run the {loop-skill} together.
Read the `{loop-skill}` skill for how you two collaborate.

**Your partner:** {partner} — {one-line description of what they do}.
{Communication protocol: who sends what, when to escalate}.

**Your role in the larger team ({N} agents):**
- {upstream agent} → YOU → {downstream agent}
- You receive {what} from {upstream}
- When {completion condition}, {downstream} picks up your output

**Standing rules:** {commit strategy, reporting, etc.}
```

### Example: Builder in a 5-Agent ML Experiment Team

```
You are the builder on the ml-experiment team.

**Your subloop:** You and "reviewer" run the code-review-loop together.
Read the `code-review-loop` skill for how you two collaborate.

**Your partner:** reviewer — they review your implementations for
correctness, test coverage, and adherence to the architecture plan.
You revise and resubmit until they approve, then mark the task complete.

**Your role in the larger team (5 agents):**
- researcher finds papers → architect plans features → YOU implement →
  experiment-manager launches runs → evaluator monitors results
- You receive implementation plans from architect via task assignments
- When reviewer approves your code, experiment-manager picks it up

**Standing rules:** commit+push after each approved implementation.
```

### Why This Works

- **Subloop skills are reusable.** The same `code-review-loop` works whether it's nested inside an ML experiment team, a feature dev team, or running standalone.
- **Agents get just enough context.** They know their partner and their upstream/downstream — not everyone's business. This keeps their context focused.
- **The lead doesn't micromanage subloops.** The skill handles the collaboration protocol. The lead only intervenes when the subloop needs external input or produces output for the next stage.
- **Subgroups can scale independently.** If the builder ⇄ reviewer loop is the bottleneck, spawn builder-2 and reviewer-2 as a second pair without touching the rest of the team.

### Nesting Depth

Keep it to **two levels**: team → subloop. If you find yourself nesting deeper (sub-sub-loops), flatten the structure instead — split into separate sequential teams or promote the sub-sub-loop to a top-level subloop.

## See Also

- `fact-checking-loop` — Verified pipeline for checking factual claims
- `ml-experiment-loop` — (future) Research → plan → implement → experiment → evaluate
- `code-review-loop` — (future) Audit → fix → re-audit cycle

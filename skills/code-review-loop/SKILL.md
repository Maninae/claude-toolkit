---
name: code-review-loop
description: "Use when implementing any non-trivial feature or fix. Coder writes industrial-grade code, reviewer adversarially validates until fully satisfied. No loose ends, no shortcuts."
---

# Code Review Loop

A bidirectional loop between a meticulous coder and an adversarial (but friendly) reviewer. The code doesn't ship until the reviewer is completely satisfied — and they are not easy to satisfy.

**References:** `generalized-loop-patterns` for shared principles (see: Nested Loops & Subgroup Awareness).

## Philosophy

This is not a rubber-stamp review. This is two craftspeople holding each other to the highest standard.

**The Coder** is obsessive about implementation quality. No loose ends. Every variable name is descriptive and intentional. Functions are decomposed — no monoliths. Interfaces, enums, and abstractions are thoughtful choices, not afterthoughts. The coder's code should read like it was written by someone who cares deeply about the next person who touches it.

**The Reviewer** brings fresh eyes and a critical perspective. They are adversarial in a friendly way — actively hunting for holes, edge cases, naming inconsistencies, missing tests, leaky abstractions, and anything that isn't airtight. They don't just read code — they run tests, check edge cases, and verify deterministically. They are hard to satisfy because the standard is industrial-grade enterprise code.

Both operate within the design and intention constraints of the project. The goal isn't gold-plating — it's making the intended design bulletproof.

## The Loop

```
Coder  ──→  implementation  ──→  Reviewer
  ↑                                  │
  └────────  feedback  ←─────────────┘
             (repeat until reviewer fully satisfied)
                                     │
                              ──→  Lead (approved)
```

### Round 1: Implementation

Coder receives the task and implements with full intensity:

**Code Quality Bar:**
- Descriptive variable names: `noise_pred` not `np`, `alpha_bar_t` not `ab`
- Decomposed functions — each does one thing, named for what it does
- No monolith functions. If a function has 3+ logical phases, split it.
- Thoughtful interfaces: enums over magic strings, typed parameters over `**kwargs` soup
- Type annotations on all function signatures
- Shape comments after tensor operations: `# (B, C, H, W)`
- Edge cases handled or explicitly documented as out-of-scope
- No dead code, no commented-out blocks, no TODOs without tickets

**What the coder sends to reviewer:**
- List of files created/modified
- Brief description of the approach and key design decisions
- Any trade-offs made and why
- "Ready for review"

### Round 2+: Review

Reviewer pulls the code and performs a thorough adversarial review:

**Review Protocol:**
1. **Read the code end-to-end.** Understand the full flow before nitpicking.
2. **Run the tests.** All existing tests must pass. If there are no tests, that's finding #1.
3. **Check edge cases.** What happens with empty input? Single item? Maximum size? Null/None?
4. **Validate naming.** Every variable, function, class, and module name should be self-documenting.
5. **Trace the data flow.** Follow a request/data through the full path. Any place where the type is ambiguous or a transformation is surprising?
6. **Check interfaces.** Are function signatures clean? Would a caller know how to use this without reading the implementation?
7. **Look for missing abstractions.** Is there repeated logic that should be extracted? Conversely, are there premature abstractions that add complexity without value?
8. **Security and correctness.** Injection risks, race conditions, resource leaks, off-by-one errors.
9. **Test coverage.** Are the tests testing behavior or just exercising code? Do they cover failure modes?

**Review feedback format:**
```
## Review: [file or feature]

### Must Fix (blocks approval)
1. [Specific issue with file:line reference]
   - What's wrong: ...
   - Suggested fix: ...

### Should Fix (strongly recommended)
1. ...

### Nitpicks (optional, take-or-leave)
1. ...

### What's Good
- [Acknowledge strong choices — this isn't just about finding problems]
```

**Reviewer does NOT approve if:**
- Any "Must Fix" items remain
- Tests don't pass
- Tests don't exist for new functionality
- There's a code path they can't reason about
- Naming is unclear enough that they had to re-read to understand

### Iteration

Coder addresses all "Must Fix" items and responds to "Should Fix" with either a fix or a reasoned explanation. Sends back to reviewer.

Reviewer re-checks only the changed areas plus any areas affected by the changes. This is NOT a full re-review — it's a delta review.

**Typical iterations:** 2-3 rounds. If it goes beyond 3, the coder and reviewer should align on the design with the lead before continuing.

### Approval

When the reviewer is fully satisfied:
1. Reviewer sends approval to lead: "Approved. All issues addressed, tests pass, code is clean."
2. Coder commits and pushes the final version
3. Both agents report completion to lead

## Spawn Prompts

### Coder

```
You are the coder on the {team-name} team.

**Your subloop:** You and "reviewer" run the code-review-loop together.

**Your partner:** reviewer — they adversarially review your code with
fresh eyes. They are hard to satisfy. That's by design.

**Your standard:** Industrial-grade code. No loose ends.
- Descriptive variable names (noise_pred not np, alpha_bar_t not ab)
- Decomposed functions — no monoliths, each function does one thing
- Thoughtful interfaces: enums over magic strings, typed params
- Type annotations on all function signatures
- Shape comments after tensor ops: # (B, C, H, W)
- Edge cases handled or documented as out-of-scope
- No dead code, no TODOs without tickets

**Protocol:** Implement fully, then send to reviewer. Address all
"Must Fix" feedback. Respond to "Should Fix" with a fix or a reason.
Iterate until reviewer approves. Then commit and push.

**Standing rules:** {project-specific rules}
```

### Reviewer

```
You are the reviewer on the {team-name} team.

**Your subloop:** You and "coder" run the code-review-loop together.

**Your partner:** coder — they implement features. Your job is to make
sure their code is airtight before it ships.

**Your standard:** You are adversarial in a friendly way. You actively
hunt for holes. You are NOT easy to satisfy. The bar is industrial-grade
enterprise code — within the design constraints of the project.

**Review protocol:**
1. Read the code end-to-end before commenting
2. Run ALL tests — they must pass
3. Check edge cases, naming, data flow, interfaces, security
4. Verify test coverage — tests must test behavior, not just exercise code

**Feedback format:** Must Fix (blocks approval), Should Fix (strongly
recommended), Nitpicks (optional). Always acknowledge what's good.

**You do NOT approve if:** Any Must Fix remains, tests don't pass,
tests don't exist for new code, or you can't reason about a code path.

**When satisfied:** Send approval to team-lead with summary.
```

## Integration with Larger Teams

When this loop runs as a subgroup within a larger team (see `generalized-loop-patterns` → Nested Loops):

- Coder receives tasks from upstream (architect, lead, task list)
- Reviewer's approval is the gate for downstream (experiment-manager, deployer)
- Lead doesn't intervene in the review loop unless it exceeds 3 rounds
- Both agents know their upstream/downstream in the spawn prompt

## Scaling Under Pressure

If the code-review-loop is the bottleneck in a larger pipeline:

```
# Parallel pairs
coder-1 ⇄ reviewer-1  (feature A)
coder-2 ⇄ reviewer-2  (feature B)
```

Each pair works independently on different tasks. Don't share reviewers across multiple coders — it creates a bottleneck and context-switching overhead.

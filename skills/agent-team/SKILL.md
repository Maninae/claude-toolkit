---
name: agent-team
description: Use when starting a session that involves building, researching, or any non-trivial work — spawns the default agent team with researcher-planner, builder, and reviewer teammates
---

# Default Agent Team

Spawn a 3-teammate team at session start. The lead (you) orchestrates — never do implementation, research, or review yourself. All teammates follow `~/Developer/CLAUDE.md` standards.

## Team Composition

### Lead (You)
- **Role:** Orchestration only. Human's interface. Dispatch, relay, coordinate.
- **Guard your context:** Never read long files, search codebases, or browse the web. Delegate everything.
- **Route work** using full mode or light mode (see below).

### Researcher-Planner (`researcher`)
- **Role:** Deep thinking, online research, file exploration, plan refinement.
- Take vague requests and refine into well-formed, actionable plans
- Ask clarifying questions, interrogate assumptions before anything gets built
- Search the web, read docs, explore codebases
- Write plans to the team's `plans/` directory (see Artifacts below)
- When idle: review points raised by the reviewer, assess if any warrant a new plan
- May make trivial fixes (< 5 lines) discovered during exploration

### Builder (`builder`)
- **Role:** Implementation with 10x engineering excellence.
- Read plans from the team's `plans/` directory and implement exactly to spec
- Follow TDD, SOLID, clean naming, type annotations
- Self-review before reporting done
- Iterate on reviewer feedback until approved
- **Standards:** Every line of code should be the best version of itself. No shortcuts, no "good enough."
- Do not make architectural decisions or deviate from spec without escalating to lead

### Reviewer (`reviewer`)
- **Role:** Adversarial quality gate. Keep the builder accountable.
- Review builder's output against the plan — did they build what was asked?
- Run tests, check regressions, verify edge cases
- Provide specific, actionable feedback — not vague "looks good"
- Block completion until quality bar is met
- Does NOT fix code directly — sends feedback to builder
- When idle: audit codebase for weaknesses, tech debt, security issues, surface improvement opportunities to researcher

## Coordination: Harness vs. Artifacts

Two systems work together:

### Built-in Harness (real-time coordination)
Use `TaskCreate`, `TaskUpdate`, `TaskList` for live task tracking during the session. This is how teammates claim work, report progress, and stay in sync. The harness is ephemeral — it lives for the session.

### Team Artifacts (persistent, human-readable record)
Each team gets its own directory under `~/Developer/.agent/teams/`. **Nothing is deleted.** These are the durable artifacts — plans, specs, reviews, research — that outlive the session.

**Purpose:** Human-readable record of what was planned, built, and reviewed. If another team ever needs to know what we did, or if we need to recover context months later, it's all here.

**Every teammate maintains artifacts as they work.** Researcher writes plans before handing off. Builder can annotate implementation notes. Reviewer writes findings. This is not optional — it's part of the workflow.

### Directory Structure

```
~/Developer/claude_teams/<team-name>/
├── plans/          # Researcher writes specs here
├── reviews/        # Reviewer writes findings here
└── notes/          # Research dumps, context, coordination
```

The lead creates this structure when spawning the team. Team name should be descriptive of the session's focus (e.g., `warren-icons`, `home-camera-mvp`, `imsg-setup`).

### File Naming

All files use: `YYYYMMDD-HHMMSS_slug-description.md`

Examples:
- `plans/20260319-143022_host-validation.md`
- `reviews/20260319-161200_icon-pipeline-findings.md`
- `notes/20260319-140000_squircle-research.md`

## Routing Modes

### Full Mode (default)
For ambiguous, complex, or multi-step requests:
```
Human → Researcher refines → Plan artifact → Builder implements → Reviewer audits
```

### Light Mode
For simple, well-specified requests (install a tool, rename something, small fix). Lead writes a quick plan and sends directly to builder:
```
Human → Lead writes plan → Builder implements → Reviewer audits
```
Skip reviewer for non-code tasks (installs, git operations, renames). Always review if code was written.

## Pipeline & Parallelism

The team operates as an **assembly line**. All three teammates should be active simultaneously.

### Queue Structure

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  Researcher  │ →  │   Builder    │ →  │  Reviewer    │
│  Task 3      │    │  Task 2      │    │  Task 1      │
│  Task 4      │    │  (queued: 3) │    │  (queued: 2) │
└─────────────┘    └─────────────┘    └─────────────┘
```

1. **Researcher** finishes plan for Task 1, immediately starts Task 2
2. **Builder** picks up Task 1, implements. When done, picks up Task 2 (if ready)
3. **Reviewer** audits Task 1. Fail? Builder pauses Task 2 to fix, then resumes
4. **Researcher** is already on Task 3

### Parallelism Rules
- Researcher always works ahead — never idle if there's a next task
- Builder prioritizes reviewer feedback over new tasks (fix before advancing)
- Lead manages the queue and enforces ordering for dependent tasks
- Independent tasks flow freely through the pipeline

## Rules

1. **All teammates: `bypassPermissions`, Opus model.** No permission gates, no downgrades.
2. **Lead never reads code, searches files, or browses the web.** Delegate everything.
3. **Artifacts persist.** Nothing in the team directory is deleted. Timestamped, always referenceable.
4. **Reviewer blocks, not advises.** Builder must address all feedback before completion.
5. **Idle teammates are productive.** Researcher plans ahead; reviewer audits for improvements.
6. **Pipeline parallelism is the default.** All three stages run concurrently.
7. **Fix before advance.** Reviewer feedback on Task N takes priority over Task N+1.
8. **Escalate, don't assume.** Uncertain? Ask the lead.

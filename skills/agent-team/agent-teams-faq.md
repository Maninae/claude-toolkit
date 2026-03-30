# Agent Teams FAQ

Quick reference for leading and coordinating Claude Code agent teams.

---

## Communication

**Q: How do teammates communicate?**
Teammates use `SendMessage` with `to: "<name>"` for direct messages or `to: "*"` for broadcast. Plain text output is NOT visible to the team — you MUST use SendMessage. Broadcasting is expensive (sends a separate message to every teammate), so default to direct messages.

**Q: How does message delivery work?**
Messages are delivered automatically to recipients' inboxes. The lead does not need to poll. When a teammate sends a message, it arrives at the recipient without any action required.

**Q: Can the user talk to teammates directly?**
Yes. In-process mode: Shift+Down cycles through teammates, type to message them, Enter to view their session, Escape to interrupt their turn. Split-pane mode: click into a teammate's pane.

---

## Task System

**Q: How does the task list work?**
Shared across the team. Tasks have three states: `pending`, `in_progress`, `completed`. Tasks can have dependencies — a pending task with unresolved deps cannot be claimed. Stored at `~/.claude/tasks/{team-name}/`.

**Q: How are tasks assigned?**
Two ways: the lead assigns explicitly, or teammates self-claim the next unassigned/unblocked task after finishing one. Task claiming uses file locking to prevent race conditions.

**Q: What's the right task size?**
5-6 tasks per teammate is the sweet spot. Too small = coordination overhead exceeds benefit. Too large = teammates work too long without check-ins. Each task should produce a clear deliverable (a function, test file, review).

---

## Idle & Lifecycle

**Q: How do idle notifications work?**
When a teammate finishes and stops, it automatically notifies the lead. No polling needed. The `TeammateIdle` hook runs when a teammate is about to go idle — exit code 2 sends feedback and keeps them working.

**Q: How do you shut down a teammate?**
Tell the lead: "Ask the researcher teammate to shut down." The lead sends a shutdown request. The teammate can approve (exits) or reject with a reason. Shutdown can be slow — teammates finish their current request/tool call first.

**Q: How do you clean up the team?**
Tell the lead: "Clean up the team." It removes shared team resources. All teammates must be shut down first or cleanup fails. Only the lead should run cleanup — teammates may leave resources in an inconsistent state.

---

## Team Configuration

**Q: How does the team config file work?**
Stored at `~/.claude/teams/{team-name}/config.json`. Contains a `members` array with each teammate's name, agent ID, and agent type. Teammates can read this to discover other team members.

**Q: How do you enable agent teams?**
Set `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` to `1` in settings.json under `env`, or in your shell environment. Requires Claude Code v2.1.32+.

**Q: What display modes are available?**
- **in-process** (default): all teammates in your main terminal. Shift+Down to cycle. Works anywhere.
- **tmux/iTerm2 split panes**: each teammate gets its own pane. Set `"teammateMode": "tmux"` in settings.json. Not supported in VS Code terminal, Windows Terminal, or Ghostty.
- **auto** (default): uses split panes if already in tmux, in-process otherwise.

Override per-session: `claude --teammate-mode in-process`

---

## Permissions & Context

**Q: What tools do teammates have access to?**
Same tools as any Claude Code session: Bash, Read, Edit, Write, Glob, Grep, plus SendMessage, TaskCreate/Update/Get/List for team coordination. They also load CLAUDE.md, MCP servers, and skills from the working directory.

**Q: How do permissions work?**
Teammates inherit the lead's permission settings at spawn. If the lead uses `--dangerously-skip-permissions`, all teammates do too. You can change individual teammate modes after spawning, but not at spawn time.

**Q: Do teammates get the lead's conversation history?**
No. They get project context (CLAUDE.md, MCP servers, skills) plus the spawn prompt from the lead. The lead's conversation history does not carry over.

**Q: Can you require plan approval before implementation?**
Yes. Spawn with plan mode required — the teammate works read-only until the lead approves their plan. If rejected, they revise and resubmit.

---

## Hooks

**Q: What hooks are available for quality gates?**
- `TeammateIdle`: runs when a teammate is about to go idle. Exit code 2 sends feedback and keeps them working.
- `TaskCompleted`: runs when a task is being marked complete. Exit code 2 prevents completion and sends feedback.

---

## Gotchas & Limitations

**Q: What are the key limitations?**
- **No session resumption**: `/resume` and `/rewind` do not restore in-process teammates. After resuming, the lead may try to message dead teammates — tell it to spawn new ones.
- **Task status can lag**: teammates sometimes fail to mark tasks completed, blocking dependents. Check manually and nudge.
- **One team per session**: clean up the current team before starting a new one.
- **No nested teams**: teammates cannot spawn their own teams. Only the lead manages the team.
- **Lead is fixed**: can't promote a teammate to lead or transfer leadership.
- **File conflicts**: two teammates editing the same file causes overwrites. Break work so each teammate owns different files.

**Q: What if the lead starts doing work itself instead of delegating?**
Tell it: "Wait for your teammates to complete their tasks before proceeding."

**Q: What if teammates stop on errors?**
Check their output (Shift+Down or click pane), give additional instructions directly, or spawn a replacement.

**Q: What about orphaned tmux sessions?**
`tmux ls` to list, `tmux kill-session -t <name>` to clean up.

---

## Team Sizing

**Q: How many teammates should I use?**
Start with 3-5. Token costs scale linearly (each teammate has its own context window). Three focused teammates often outperform five scattered ones. Scale up only when work genuinely benefits from parallelism.

**Q: When should I use agent teams vs subagents?**
- **Subagents**: focused tasks where only the result matters. Lower token cost. Workers report back to caller only.
- **Agent teams**: complex work requiring discussion, shared findings, and self-coordination. Higher token cost. Workers message each other directly.

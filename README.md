# claude-toolkit

Central skill and command store for Claude Code. Edit here, push, pull on another machine — symlinks keep everything in sync.

## Install

```bash
git clone git@github.com:ojwang/claude-toolkit.git ~/Developer/claude-toolkit
cd ~/Developer/claude-toolkit
./install.sh
```

This symlinks every item in `skills/` and `commands/` into `~/.claude/skills/` and `~/.claude/commands/`. Existing non-symlink files are skipped with a warning.

## Structure

```
claude-toolkit/
├── install.sh              # Symlink installer
├── skills/                 # 24 skills (auto-loaded by Claude Code)
│   ├── writing-plans/
│   ├── executing-plans/
│   ├── planning-with-files/
│   ├── senior-architect/
│   ├── senior-fullstack/
│   ├── frontend-dev-guidelines/
│   ├── bun-development/
│   ├── javascript-mastery/
│   ├── ui-ux-pro-max/
│   ├── canvas-design/
│   ├── core-components/
│   ├── react-best-practices/
│   ├── systematic-debugging/
│   ├── verification-before-completion/
│   ├── playwright-skill/
│   ├── webapp-testing/
│   ├── autonomous-agent-patterns/
│   ├── dispatching-parallel-agents/
│   ├── subagent-driven-development/
│   ├── mcp-builder/
│   ├── file-organizer/
│   ├── app-store-optimization/
│   ├── never-use-rm.md
│   └── xcode.md
└── commands/               # 8 commands (user-invocable via /name)
    ├── resume.md
    ├── wrapup.md
    ├── commit.md
    ├── push.md
    ├── gmp.md
    ├── cc.md
    ├── trawl.md
    └── grill.md
```

## Skills

| Category | Skills |
|----------|--------|
| **Planning** | writing-plans, executing-plans, planning-with-files |
| **Development** | senior-fullstack, senior-architect, frontend-dev-guidelines |
| **Debugging** | systematic-debugging, verification-before-completion |
| **UI/UX** | ui-ux-pro-max, canvas-design, core-components |
| **Testing** | playwright-skill, webapp-testing |
| **Agents** | autonomous-agent-patterns, dispatching-parallel-agents, subagent-driven-development |
| **Frameworks** | bun-development, react-best-practices, javascript-mastery |
| **Infrastructure** | mcp-builder |
| **Utilities** | file-organizer, app-store-optimization |
| **Rules** | never-use-rm, xcode |

## Commands

| Command | Purpose |
|---------|---------|
| `/resume` | Get up to speed on recent sessions |
| `/wrapup` | Document session before ending |
| `/commit` | Create git commit with conventional message |
| `/push` | Push to origin/main |
| `/gmp` | Commit and push in one go |
| `/cc` | Check context/token usage |
| `/trawl` | Deep codebase exploration |
| `/grill` | Rigorous requirements interview |

## Adding a new skill

Create a folder or file in `skills/`:

```
skills/my-skill/SKILL.md    # folder-based (can include scripts/, references/)
skills/my-skill.md          # single-file
```

Run `./install.sh` to symlink it. All machines get it after `git pull && ./install.sh`.

## Syncing across machines

```bash
# Machine A: edit and push
cd ~/Developer/claude-toolkit
git add -A && git commit -m "feat: add new skill" && git push

# Machine B: pull and relink
cd ~/Developer/claude-toolkit
git pull && ./install.sh
```

# Session: Simplify llms_shared_context → claude-toolkit

**Date**: 2026-03-26
**Goal**: Strip the multi-LLM repo down to a clean, Claude Code-only skill/command store that syncs across machines via git + symlinks.

---

## Approach

Started from a detailed plan (created in plan mode in a prior turn) that specified every directory move, file edit, and deletion. Executed the plan step-by-step, verifying structure at each stage.

## Key Decisions

- **Repo rename**: `llms_shared_context` → `claude-toolkit` (both GitHub and local directory)
- **workflows/ → commands/**: Renamed to match Claude Code's terminology. Commands live at repo root in `commands/` and symlink into `~/.claude/commands/`.
- **Rules converted to skills**: `never_use_rm_only_trash.md` and `xcode.md` moved from `rules/` into `skills/` as single-file skills with frontmatter.
- **Dropped `llm-app-patterns`**: The only skill removed (23 → 22 folder-based skills + 2 single-file skills = 24 total).
- **Preserved existing standalone skills**: `~/.claude/skills/wrapup/` and `~/.claude/skills/write-like-human/` were already present as real directories — installer skips non-symlink items, so these are untouched.
- **Preserved existing standalone command**: `~/.claude/commands/teach.md` similarly preserved.

## Work Performed (chronological)

1. **Explored current repo structure** — listed all directories (`skills/`, `workflows/`, `rules/`, `templates/`, `scripts/`) and read all workflow files, rule files, and README.
2. **Checked `~/.claude/skills/` and `~/.claude/commands/`** — found `wrapup/`, `write-like-human/` (skills) and `teach.md` (command) already present.
3. **Created `commands/`** — copied all 8 `.md` files from `workflows/`.
4. **Fixed `.agent/` references** in three commands:
   - `commands/resume.md`: `.agent/history/` → `.claude/history/`, removed GEMINI.md-specific "After Reading" instructions (create session dir, etc.) and simplified to "reference previous next steps + pick up where you left off".
   - `commands/wrapup.md`: `.agent/history/` → `.claude/history/` (3 occurrences).
   - `commands/trawl.md`: `.agent/` → `.claude/` across all paths (history, techdocs, rules, skills, future_features).
5. **Converted rules to skills** — created `skills/never-use-rm.md` and `skills/xcode.md` with proper `---` frontmatter (name + description).
6. **Deleted old artifacts** (all via `trash -v`):
   - `skills/llm-app-patterns/`
   - `templates/` (AGENT_INSTRUCTIONS.template.md, GEMINI.template.md)
   - `scripts/` (init.sh, update.sh)
   - `rules/` (never_use_rm_only_trash.md, README.md, xcode.md)
   - `workflows/` (all 8 .md files — already copied to commands/)
7. **Created `install.sh`** (~30 lines) — iterates `skills/` and `commands/`, symlinks each item into `~/.claude/skills/` and `~/.claude/commands/`. Re-links existing symlinks, skips existing non-symlink items with a warning.
8. **Rewrote `README.md`** — removed all Gemini/Cursor/multi-LLM content. New README covers: what this is, install instructions, full structure tree, skill inventory table, command table, how to add skills, syncing across machines.
9. **Ran `install.sh`** — confirmed all 24 skills and 8 commands symlinked correctly.
10. **Renamed repo on GitHub** — `gh repo rename claude-toolkit`.
11. **Renamed local directory** — `mv llms_shared_context claude-toolkit`.
12. **Re-ran `install.sh`** — updated all symlink targets to new path.

## Artifacts Created

- `commands/` directory with 8 command files (moved from workflows/)
- `skills/never-use-rm.md` (converted from rules/)
- `skills/xcode.md` (converted from rules/)
- `install.sh` (new symlink installer)
- `README.md` (complete rewrite)

## Artifacts Deleted

- `workflows/` directory
- `rules/` directory
- `templates/` directory
- `scripts/` directory (init.sh, update.sh)
- `skills/llm-app-patterns/`

## Lessons / Takeaways

- The installer's "skip non-symlink" behavior is important — user has standalone skills (`wrapup/`, `write-like-human/`) and a standalone command (`teach.md`) that must not be overwritten.
- After renaming the local directory, symlinks must be recreated since they use absolute paths.
- The `resume.md` command had GEMINI.md-era instructions (create session directories) that no longer apply in the Claude Code workflow — cleaned those out.

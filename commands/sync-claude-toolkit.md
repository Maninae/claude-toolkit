---
description: Sync new skills and commands from ~/.claude to the claude-toolkit repo, then commit and push so all machines stay in sync.
---

# /sync-claude-toolkit — Register & Push New Skills/Commands

Sync any locally-created skills or commands into the claude-toolkit repo so they can be pulled on other machines.

// turbo-all

## Steps

1. **Identify the repo and installed locations:**
   - Repo: `~/Developer/claude-toolkit`
   - Installed: `~/.claude/commands` and `~/.claude/skills`

2. **Find new commands** not yet in the repo:
   - List all files in `~/.claude/commands/`
   - For each file: skip if it's a symlink (already managed by the repo). If it's a real file and does NOT exist in `~/Developer/claude-toolkit/commands/`, it's new.
   - Copy each new command file into `~/Developer/claude-toolkit/commands/`
   - Then replace the original with a symlink (move to Trash, never rm -rf):
     ```bash
     cp ~/.claude/commands/NEW_FILE ~/Developer/claude-toolkit/commands/NEW_FILE
     mv ~/.claude/commands/NEW_FILE ~/.Trash/
     ln -s ~/Developer/claude-toolkit/commands/NEW_FILE ~/.claude/commands/NEW_FILE
     ```

3. **Find new skills** not yet in the repo:
   - List all directories and files in `~/.claude/skills/`
   - For each item: skip if it's a symlink. If it's a real file/directory and does NOT exist in `~/Developer/claude-toolkit/skills/`, it's new.
   - Copy each new skill into `~/Developer/claude-toolkit/skills/` (use `cp -r` for directories)
   - Then replace the original with a symlink (move to Trash, never rm -rf):
     ```bash
     cp -r ~/.claude/skills/NEW_ITEM ~/Developer/claude-toolkit/skills/NEW_ITEM
     mv ~/.claude/skills/NEW_ITEM ~/.Trash/
     ln -s ~/Developer/claude-toolkit/skills/NEW_ITEM ~/.claude/skills/NEW_ITEM
     ```

4. **Check for updated content** in existing items:
   - For each symlink in `~/.claude/commands/` and `~/.claude/skills/` that points into the repo, the content is already in-repo — no action needed.
   - Run `git -C ~/Developer/claude-toolkit status --short` to see if anything changed.

5. **Report what was found:**
   - List all new commands and skills that were copied in.
   - If nothing new was found, say "Everything is already in sync." and stop.

6. **Commit and push:**
   ```bash
   cd ~/Developer/claude-toolkit
   git add -A
   git status --short
   ```
   - Generate a commit message like: `feat: add {list of new items}`
   ```bash
   git commit -m "GENERATED_MESSAGE"
   git push origin main
   ```

7. **Confirm:**
   ```bash
   git -C ~/Developer/claude-toolkit log --oneline -1
   ```
   - Print a summary: what was synced, and remind the user to run `install.sh` on their other machines (or `git pull` + `./install.sh`).

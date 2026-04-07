# Claude Code — Policy Files

This folder contains the managed Claude Code policies deployed to all Life Church Macs via Mosyle.

---

## Files

### `CLAUDE.md`
The behavioral instruction file loaded by Claude Code on every managed Mac. It shapes how Claude behaves across all projects — things like slowing down before making changes, asking questions before building, knowing when to loop in IT, and keeping work local until it's ready to go further.

This file is pulled from GitHub daily by Mosyle and placed at `/etc/claude-code/CLAUDE.md`. It's then imported at the bottom of each user's personal `~/.claude/CLAUDE.md` so their own preferences are preserved above it.

**To view the live file:** [software/claude/CLAUDE.md](./CLAUDE.md)

---

### `managed-settings.json`
A JSON settings file deployed to `/Library/Application Support/ClaudeCode/managed-settings.json`. This is the Claude Code managed settings layer — it enforces permission rules that prevent Claude from automatically running high-risk commands on a user's behalf.

**What it blocks Claude from doing automatically:**
- Running `sudo` or privilege escalation
- `rm -rf` — recursive force deletion
- `curl ... | bash` or `wget ... | bash` — piping remote scripts directly into execution
- `chmod` / `chown` — changing file permissions or ownership
- `brew install` — installing software packages
- `npm install -g` — installing global Node packages
- `pip install --system` — installing Python packages system-wide
- `launchctl` / `systemctl` — managing system services
- `git push --force` — force-pushing to a git repo
- Reading `.env` files, `*.pem`, `*.key`, or anything in a `secrets/` folder

Users can still run any of these themselves in Terminal — this only prevents Claude from doing it automatically.

---

### `deploy-claude-policy.sh`
Mosyle script that pulls the latest `CLAUDE.md` from GitHub to `/etc/claude-code/CLAUDE.md` and wires the import block into the user's `~/.claude/CLAUDE.md`. Runs daily as root.

### `deploy-managed-settings.sh`
Mosyle script that pulls the latest `managed-settings.json` from GitHub and places it at `/Library/Application Support/ClaudeCode/managed-settings.json`. Runs daily as root.

### `remove-claude-policy.sh`
Removes the managed policy file and cleans up the import block from the user's `~/.claude/CLAUDE.md`. Run manually as root to offboard a device.

### `DEPLOYMENT.md`
Step-by-step guide for setting up the Mosyle scripts and verifying deployment on a test Mac.

---

## Updating a Policy

1. Create a branch and make your changes
2. Open a PR and get at least one reviewer to approve
3. Merge to `main`
4. Mosyle picks up the change on the next scheduled run (up to 24 hours)

The `managed-settings.json` also needs to be updated manually in the Claude admin console after merging — see `DEPLOYMENT.md` for details.

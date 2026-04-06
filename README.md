# claude-vibe-coder

**The Life Church — Global Claude Code Policy**

This repo manages the Claude Code policy and permissions for Life Church Macs. It contains three deployable artifacts that work together as a layered security and behavior system.

---

## Deployment Architecture

Claude Code is controlled through three complementary layers:

| Layer | File | Where it goes | What it enforces | Tamper-proof? |
|---|---|---|---|---|
| **Mosyle Config Profile** | `claude-code-policy.mobileconfig` | Mosyle → Custom Configuration Profile | Deny list + bypass mode | Yes — OS-enforced |
| **Claude Admin Console** | `managed-settings.json` | claude.ai org admin settings | Deny list + bypass mode + announcement | Yes — server-enforced |
| **Mosyle Shell Script** | `deploy-claude-policy.sh` | Mosyle → Custom Script (daily) | CLAUDE.md behavioral policy | Soft (file-based) |

### Why three layers?

- **Mosyle profile** catches users on personal Claude accounts (not signed into the TLC org)
- **Admin console** catches org account users on unmanaged machines (personal Macs, borrowed devices)
- Together they cover every scenario except a personal account on a personal Mac — which is outside TLC's systems entirely

Users own their own allow lists via `~/.claude/settings.json`. IT does not manage those.

---

## Files

| File | Purpose |
|---|---|
| `CLAUDE.md` | Behavioral policy — loaded by Claude Code on every managed Mac via `deploy-claude-policy.sh` |
| `managed-settings.json` | Permission settings — paste into Claude.ai org admin console |
| `claude-code-policy.mobileconfig` | Mosyle configuration profile — upload to Mosyle as a Custom Configuration Profile |
| `deploy-claude-policy.sh` | Shell script — deploy via Mosyle as a recurring daily Custom Script |

---

## Deployment Instructions

### 1. Mosyle Configuration Profile
1. Go to Mosyle → **MDM Profiles** → **Add Profile** → **Custom Profile**
2. Upload `claude-code-policy.mobileconfig`
3. Scope to your vibe coder device group
4. Deploy

This is OS-enforced. Users cannot remove it even with local admin rights.

**Before rolling out org-wide**, test on one machine:
```bash
defaults read com.anthropic.claudecode
```
Confirm the deny list and `disableBypassPermissionsMode` are present in the output.

### 2. Claude Admin Console
1. Go to claude.ai → Admin → Settings
2. Paste the contents of `managed-settings.json` into the managed settings field
3. Save — applies immediately to all org account users

### 3. Mosyle Shell Script (CLAUDE.md policy)
1. Go to Mosyle → **Custom Scripts** → **Add Script**
2. Upload `deploy-claude-policy.sh`
3. Set to run **as root** on a **daily** schedule
4. No arguments needed

To update the behavioral policy: edit `CLAUDE.md` and merge to `main`. Mosyle handles the rest.

---

## What the Permissions Block

| Command | Reason |
|---|---|
| `sudo` | System-level privilege escalation |
| `rm -rf` | Destructive file deletion |
| `curl/wget \| bash` | Remote code execution |
| `chmod`, `chown` | Permission and ownership changes |
| `kill`, `killall`, `pkill` | Process termination |
| `dd`, `mkfs`, `fdisk` | Disk operations |
| `brew install` | System package installs — IT manages these |
| `npm install -g` | Global Node installs |
| `pip install --system` | System Python installs |
| `crontab`, `launchctl`, `systemctl` | Scheduled task and service management |
| `git push --force` / `--force-with-lease` | Destructive git operations |
| `.env`, `*.pem`, `*.key`, `secrets/**` | Reading secrets and credentials |

---

## Questions

Reach out to IT. This is managed by The Life Church IT/Dev team.

# Claude Code — Deployment Guide

Policies are pulled directly from `The-Life-Church/tlc-tech-policies` on GitHub. Mosyle runs each script on a daily schedule — merge a PR to `main` and devices pick it up automatically on the next run.

---

## Behavioral Policy (CLAUDE.md)

Mosyle → **Custom Scripts → Add Script**
- Run as: `root`
- Schedule: Daily
- Scope: Default group
- Script:
```bash
#!/bin/zsh
curl -fsSL "https://raw.githubusercontent.com/The-Life-Church/tlc-tech-policies/main/software/claude/CLAUDE.md" -o /etc/claude-code/CLAUDE.md
```

**Verify on a test Mac:**
```bash
cat /etc/claude-code/CLAUDE.md
```

---

## Permission Settings (Config Profile)

Mosyle → **MDM Profiles → Add Profile → Custom Profile**
1. Upload `claude-code-policy.mobileconfig`
2. Scope to Default group
3. Deploy

> This file must be uploaded manually — it can't be curl'd. Update it in Mosyle when the file changes in the repo.

**Verify on a test Mac:**
```bash
defaults read com.anthropic.claudecode
```

---

## Admin Console Settings

1. Open [claude.ai](https://claude.ai) → Admin → Settings
2. Paste the contents of `managed-settings.json`
3. Save

> Manual step — no Mosyle involvement. Update when the file changes in the repo.

---

## Updating a Policy

1. Create a branch, make your changes, open a PR
2. Get at least one reviewer to approve
3. Merge to `main`
4. Mosyle picks up the change on the next scheduled run (up to 24 hours)

For the config profile or admin console settings, update those manually after merging.

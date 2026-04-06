# Shell Restrictions — Deployment Guide

Policies are embedded directly in the deploy scripts. Mosyle runs each script on a daily schedule — merge a PR to `main` and devices pick it up automatically on the next run.

---

## Add Scripts in Mosyle

Mosyle → **Custom Scripts → Add Script** — one per group.

**Vibe Coders/Claude Users group**
- Run as: `root`
- Schedule: Daily
- Scope: Vibe Coders/Claude Users group
- Script:
```bash
#!/bin/bash
curl -fsSL "https://raw.githubusercontent.com/The-Life-Church/tlc-tech-policies/main/software/shell/deploy-shell-policy-vibe-coders.sh" | bash
```

**Default group**
- Run as: `root`
- Schedule: Daily
- Scope: Default group
- Script:
```bash
#!/bin/bash
curl -fsSL "https://raw.githubusercontent.com/The-Life-Church/tlc-tech-policies/main/software/shell/deploy-shell-policy-default.sh" | bash
```

**Verify on a test Mac:**
```bash
cat /etc/tlc-shell-policy.zsh
cat /etc/zshrc
```

---

## Updating a Policy

1. Create a branch, make your changes inside the relevant deploy script, open a PR
2. Get at least one reviewer to approve
3. Merge to `main`
4. Mosyle picks up the change on the next scheduled run (up to 24 hours)

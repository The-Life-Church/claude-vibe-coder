# Shell Restrictions — Policy Files

This folder contains the managed shell restriction policies deployed to Life Church Macs via Mosyle. There are two tiers — one for general staff and one for people using Claude Code.

---

## Policies

### Default — General Staff
Blocks terminal access entirely. When someone opens Terminal, they see a message explaining that it's managed by IT and directing them to submit a Systems Request if they need something.

**Deployed by:** `deploy-shell-policy-default.sh`
**Mosyle scope:** Default device group

---

### Vibe Coders — Claude Code Users
Allows normal terminal and development work, but blocks specific system-level commands. The terminal opens normally — restrictions only kick in if someone tries to run something that's managed.

**What it blocks:**
- `sudo` — privilege escalation
- `brew install` — installing software packages
- `npm install -g` — installing global Node packages
- `pip install --system` / `pip3 install --system` — installing Python packages system-wide

Everything else — git, running local servers, scripts, project work — works normally.

**Deployed by:** `deploy-shell-policy-vibe-coders.sh`
**Mosyle scope:** Vibe Coders/Claude Users device group

---

## Files

### `deploy-shell-policy-default.sh`
Mosyle script that writes the default (full block) policy to `/etc/tlc-shell-policy.zsh` and wires it into `/etc/zshrc`. Runs daily as root.

### `deploy-shell-policy-vibe-coders.sh`
Mosyle script that writes the vibe coders (selective block) policy to `/etc/tlc-shell-policy.zsh` and wires it into `/etc/zshrc`. Runs daily as root.

### `remove-shell-policy.sh`
Removes the policy file and cleans up the source line from `/etc/zshrc`. Run manually as root to offboard a device or switch policy tiers.

### `DEPLOYMENT.md`
Step-by-step guide for setting up the Mosyle scripts and verifying deployment on a test Mac.

---

## Updating a Policy

1. Create a branch and make your changes inside the relevant deploy script
2. Open a PR and get at least one reviewer to approve
3. Merge to `main`
4. Mosyle picks up the change on the next scheduled run (up to 24 hours)

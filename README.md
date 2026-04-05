# claude-vibe-coder

**The Life Church — Global Claude Code Policy**

This repo manages a shared `CLAUDE.md` policy file for Life Church Macs. When Claude Code runs on a managed machine, it automatically loads this file and adopts the tone, workflow, and guardrails defined here.

The deployment script can be wired to **Mosyle MDM** for automatic rollout across all managed machines — but that connection is not required. The policy can also be deployed manually or tested locally.

---

## What This Does

- Defines how Claude Code should behave as a creative collaborator for TLC staff
- Enforces a consistent tone: encouraging, casual, mentor-like — not bureaucratic
- Sets guardrails around API usage, GitHub org hygiene, and IT check-ins
- Establishes project setup conventions (WORKLOG, DECISIONS, IDEAS, etc.)

The policy is intentionally written for **non-developer creative staff** — people who are smart and capable but not professional engineers. Claude is positioned as a knowledgeable guide, not a gatekeeper.

---

## How It Works

`deploy-claude-policy.sh` fetches the latest `CLAUDE.md` from this repo and installs it on a machine. It:

1. Creates `/etc/claude-code/` if it doesn't exist
2. Pulls the latest `CLAUDE.md` from this repo's `main` branch
3. Writes it to `/etc/claude-code/CLAUDE.md`

Claude Code automatically discovers and loads CLAUDE.md files from `/etc/claude-code/`, making the policy available in every session on that machine.

---

## Deployment Options

### Manual / Local
Run `deploy-claude-policy.sh` directly on any Mac (as root) to install the policy on that machine.

### Via Mosyle MDM (optional, not yet configured)
The script is designed to work as a **Mosyle Custom Script** for org-wide rollout:

1. Upload `deploy-claude-policy.sh` to Mosyle as a **Custom Script**
2. Set it to run **as root**, on a **daily** schedule
3. No arguments needed — the URL is hardcoded to `main`

Once wired up, updating the policy is as simple as merging to `main` — Mosyle handles the rest.

To update the policy: edit `CLAUDE.md` and merge to `main`.

---

## Files

| File | Purpose |
|---|---|
| `CLAUDE.md` | The policy itself — loaded by Claude Code on every managed Mac |
| `deploy-claude-policy.sh` | Mosyle deployment script — fetches and installs the policy |

---

## Questions

Reach out to IT. This is managed by The Life Church IT/Dev team.

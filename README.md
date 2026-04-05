# claude-vibe-coder

**The Life Church — Global Claude Code Policy**

This repo deploys a shared `CLAUDE.md` policy file to all Life Church Macs via Mosyle MDM. When Claude Code runs on any managed machine, it automatically loads this file and adopts the tone, workflow, and guardrails defined here.

---

## What This Does

- Defines how Claude Code should behave as a creative collaborator for TLC staff
- Enforces a consistent tone: encouraging, casual, mentor-like — not bureaucratic
- Sets guardrails around API usage, GitHub org hygiene, and IT check-ins
- Establishes project setup conventions (WORKLOG, DECISIONS, IDEAS, etc.)

The policy is intentionally written for **non-developer creative staff** — people who are smart and capable but not professional engineers. Claude is positioned as a knowledgeable guide, not a gatekeeper.

---

## How It Works

`deploy-claude-policy.sh` is deployed as a **recurring daily script via Mosyle** (run as root). It:

1. Creates `/etc/claude-code/` if it doesn't exist
2. Pulls the latest `CLAUDE.md` from this repo's `main` branch
3. Writes it to `/etc/claude-code/CLAUDE.md`

Claude Code automatically discovers and loads CLAUDE.md files from `/etc/claude-code/`, making the policy available in every session on managed machines.

---

## Deployment (Mosyle)

1. Upload `deploy-claude-policy.sh` to Mosyle as a **Custom Script**
2. Set it to run **as root**, on a **daily** schedule
3. No arguments needed — the URL is hardcoded to `main`

To update the policy: edit `CLAUDE.md` and merge to `main`. Mosyle will pull the latest on the next run.

---

## Files

| File | Purpose |
|---|---|
| `CLAUDE.md` | The policy itself — loaded by Claude Code on every managed Mac |
| `deploy-claude-policy.sh` | Mosyle deployment script — fetches and installs the policy |

---

## Questions

Reach out to IT. This is managed by The Life Church IT/Dev team.

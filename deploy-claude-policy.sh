#!/bin/bash

# The Life Church — Claude Code Policy Deployment
# Deploy via Mosyle as a recurring daily script (run as root)
# Source: https://raw.githubusercontent.com/The-Life-Church/claude-vibe-coder/main/CLAUDE.md

POLICY_DIR="/etc/claude-code"
POLICY_FILE="$POLICY_DIR/CLAUDE.md"
POLICY_URL="https://raw.githubusercontent.com/The-Life-Church/claude-vibe-coder/main/CLAUDE.md"

# Create directory if it doesn't exist
mkdir -p "$POLICY_DIR"

# Pull latest policy from GitHub
curl -s "$POLICY_URL" -o "$POLICY_FILE"

# Confirm
if [ -f "$POLICY_FILE" ]; then
    echo "Claude Code policy deployed successfully."
else
    echo "ERROR: Failed to deploy Claude Code policy."
    exit 1
fi

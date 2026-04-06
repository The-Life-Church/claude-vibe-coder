#!/bin/bash

# The Life Church — Shell Policy Deployment (Default)
# Deploy via Mosyle as a recurring script (run as root)
# Scope to default (Claude Code users) device group in Mosyle.
# Source: https://raw.githubusercontent.com/The-Life-Church/tlc-tech-policies/main/software/shell/shell-policy-default.zsh

POLICY_FILE="/etc/tlc-shell-policy.zsh"
POLICY_URL="https://raw.githubusercontent.com/The-Life-Church/tlc-tech-policies/main/software/shell/shell-policy-default.zsh"
ZSHRC="/etc/zshrc"
SOURCE_LINE="source $POLICY_FILE"

curl -s "$POLICY_URL" -o "$POLICY_FILE"

if [ ! -f "$POLICY_FILE" ]; then
    echo "ERROR: Failed to deploy shell policy."
    exit 1
fi

chmod 644 "$POLICY_FILE"
chown root:wheel "$POLICY_FILE"

echo "Shell policy (default) deployed to $POLICY_FILE"

if grep -qF "$SOURCE_LINE" "$ZSHRC"; then
    echo "Shell policy already wired into $ZSHRC — nothing to do."
else
    printf "\n# TLC Managed Shell Policy\n%s\n" "$SOURCE_LINE" >> "$ZSHRC"
    echo "Shell policy wired into $ZSHRC."
fi

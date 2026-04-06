#!/bin/bash

# The Life Church — Shell Policy Removal
# Run as root to remove the managed shell policy from a Mac.

POLICY_FILE="/etc/tlc-shell-policy.zsh"
ZSHRC="/etc/zshrc"

# Remove policy file
if [ -f "$POLICY_FILE" ]; then
    rm "$POLICY_FILE"
    echo "Removed $POLICY_FILE"
else
    echo "$POLICY_FILE not found — skipping."
fi

# Remove source line and comment from /etc/zshrc
if grep -qF "tlc-shell-policy" "$ZSHRC"; then
    sed -i '' '/# TLC Managed Shell Policy/d' "$ZSHRC"
    sed -i '' '/source \/etc\/tlc-shell-policy.zsh/d' "$ZSHRC"
    echo "Removed shell policy from $ZSHRC"
else
    echo "Shell policy not found in $ZSHRC — skipping."
fi

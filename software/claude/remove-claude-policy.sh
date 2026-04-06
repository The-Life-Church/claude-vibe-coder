#!/bin/bash

# The Life Church — Claude Policy Removal
# Run as root to remove the managed Claude policy from a Mac.

POLICY_FILE="/etc/claude-code/CLAUDE.md"
CONSOLE_USER=$(stat -f "%Su" /dev/console)
USER_HOME=$(dscl . -read /Users/"$CONSOLE_USER" NFSHomeDirectory | awk '{print $2}')
USER_CLAUDE_MD="$USER_HOME/.claude/CLAUDE.md"

# Remove policy file
if [ -f "$POLICY_FILE" ]; then
    rm "$POLICY_FILE"
    echo "Removed $POLICY_FILE"
else
    echo "$POLICY_FILE not found — skipping."
fi

# Remove import block from ~/.claude/CLAUDE.md
if [ -f "$USER_CLAUDE_MD" ] && grep -qF "@$POLICY_FILE" "$USER_CLAUDE_MD"; then
    sed -i '' '/# ---------------------------------------------------------------/d' "$USER_CLAUDE_MD"
    sed -i '' '/# TLC MANAGED POLICY/d' "$USER_CLAUDE_MD"
    sed -i '' '/# Add your own content ABOVE/d' "$USER_CLAUDE_MD"
    sed -i '' '/# This is maintained by IT/d' "$USER_CLAUDE_MD"
    sed -i '' "/\@\/etc\/claude-code\/CLAUDE\.md/d" "$USER_CLAUDE_MD"
    echo "Removed policy import from $USER_CLAUDE_MD"
else
    echo "Policy import not found in $USER_CLAUDE_MD — skipping."
fi

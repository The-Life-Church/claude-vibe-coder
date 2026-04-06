#!/bin/bash

# The Life Church — Shell Policy Deployment (Default)
# Deploy via Mosyle as a recurring script (run as root)
# Scope to default (Claude Code users) device group in Mosyle.
# curl -fsSL https://raw.githubusercontent.com/The-Life-Church/tlc-tech-policies/main/software/shell/deploy-shell-policy-default.sh | bash

POLICY_FILE="/etc/tlc-shell-policy.zsh"
ZSHRC="/etc/zshrc"
SOURCE_LINE="source $POLICY_FILE"

cat > "$POLICY_FILE" << 'EOF'
# The Life Church — Shell Policy (Default)
# Managed by IT. Deployed via Mosyle. Do not edit directly.
# Full terminal restriction for non-developer staff.

echo "Terminal access is managed by IT."
echo "If you need something done, enter a Systems Request at staff.thelifechurch.com."
exit 1
EOF

chmod 644 "$POLICY_FILE"
chown root:wheel "$POLICY_FILE"

echo "Shell policy (default) deployed to $POLICY_FILE"

if grep -qF "$SOURCE_LINE" "$ZSHRC"; then
    echo "Shell policy already wired into $ZSHRC — nothing to do."
else
    printf "\n# TLC Managed Shell Policy\n%s\n" "$SOURCE_LINE" >> "$ZSHRC"
    echo "Shell policy wired into $ZSHRC."
fi

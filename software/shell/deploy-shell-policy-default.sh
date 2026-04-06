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

_tlc_install_message() {
  echo "Heads up — package installs are handled by IT."
  echo "Reach out by entering a Systems Request at staff.thelifechurch.com."
}

_tlc_blocked_message() {
  echo "Heads up — that command is handled by IT."
  echo "Reach out by entering a Systems Request at staff.thelifechurch.com."
}

# Package installs — IT managed
brew() {
  if [[ "$1" == "install" ]]; then
    _tlc_install_message; return 1
  fi
  command brew "$@"
}

npm() {
  if [[ "$1" == "install" && "$*" == *"-g"* ]]; then
    _tlc_install_message; return 1
  fi
  command npm "$@"
}

pip() {
  if [[ "$1" == "install" && "$*" == *"--system"* ]]; then
    _tlc_install_message; return 1
  fi
  command pip "$@"
}

pip3() {
  if [[ "$1" == "install" && "$*" == *"--system"* ]]; then
    _tlc_install_message; return 1
  fi
  command pip3 "$@"
}

# Privilege escalation
sudo() {
  _tlc_blocked_message; return 1
}

# Destructive file operations
rm() {
  if [[ "$*" == *"-rf"* || "$*" == *"-fr"* ]]; then
    _tlc_blocked_message; return 1
  fi
  command rm "$@"
}

# Permission and ownership changes
chmod() {
  _tlc_blocked_message; return 1
}

chown() {
  _tlc_blocked_message; return 1
}

# Process termination
killall() {
  _tlc_blocked_message; return 1
}

pkill() {
  _tlc_blocked_message; return 1
}

# Disk operations
dd() {
  _tlc_blocked_message; return 1
}

# Scheduled tasks and service management
crontab() {
  _tlc_blocked_message; return 1
}

launchctl() {
  _tlc_blocked_message; return 1
}

# Destructive git operations
git() {
  if [[ "$1" == "push" && ("$*" == *"--force"* || "$*" == *"--force-with-lease"*) ]]; then
    _tlc_blocked_message; return 1
  fi
  command git "$@"
}
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

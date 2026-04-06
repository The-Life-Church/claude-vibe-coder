# The Life Church — Shell Policy (Vibe Coders)
# Managed by IT. Deployed via Mosyle. Do not edit directly.
# To update this policy, edit shell-policy-vibe-coders.zsh in the claude-vibe-coder repo.

_tlc_install_message() {
  echo "Heads up — package installs are handled by IT."
  echo "Reach out by entering a Systems Request at staff.thelifechurch.com."
}

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

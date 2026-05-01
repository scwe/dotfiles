#!/bin/bash
set -e
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing system packages and tools (apt.sh)"
"$DIR/apt.sh"

echo "==> Linking configs and bootstrapping editors (install.sh)"
"$DIR/install.sh"

echo
echo "Done. A few manual steps remain:"
echo "  - Reboot (NVIDIA drivers + docker group + default zsh all need it)"
echo "  - Run 'gh auth login' to authenticate GitHub CLI"
echo "  - Run 'gcloud auth login' to authenticate Google Cloud SDK"
echo "  - Run 'claude' to authenticate Claude Code"

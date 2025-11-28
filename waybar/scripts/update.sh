#!/usr/bin/env bash
set -euo pipefail

echo "==> Syncing and upgrading system packages (pacman)…"
sudo pacman -Syu

# If you also use yay for AUR:
if command -v yay >/dev/null 2>&1; then
  echo
  echo "==> Upgrading AUR packages (yay)…"
  yay -Syu
fi

echo
echo "==> All done. You can close this window."
read -rp "Press Enter to exit..."

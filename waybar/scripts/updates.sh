#!/usr/bin/env bash

# Requires: pacman-contrib (for checkupdates)
# optional: yay (for AUR updates)

REPO_UPDATES=0
AUR_UPDATES=0

if command -v checkupdates >/dev/null 2>&1; then
  REPO_UPDATES=$(checkupdates 2>/dev/null | wc -l)
fi

if command -v yay >/dev/null 2>&1; then
  AUR_UPDATES=$(yay -Qua 2>/dev/null | wc -l)
fi

TOTAL=$((REPO_UPDATES + AUR_UPDATES))

if [ "$TOTAL" -gt 0 ]; then
  CLASS="updates-available"
else
  CLASS="up-to-date"
fi

# Waybar JSON output
echo "{\"text\":\" $TOTAL\",\"tooltip\":\"$REPO_UPDATES repo, $AUR_UPDATES AUR\",\"class\":\"$CLASS\"}"

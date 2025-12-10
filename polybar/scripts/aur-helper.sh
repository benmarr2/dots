
#!/usr/bin/env bash
# Robust pacman + AUR updates for polybar (yay + wezterm)
# - forces numeric output
# - defaults to 0 on errors/timeouts
# - safe with 'set -u'

set -u
export LC_ALL=C

ICON=""

# --- helpers ---------------------------------------------------------------
numonly() {
  # strip everything except digits; if empty -> 0
  local s
  s="$(printf '%s' "$1" | tr -cd '0-9')"
  if [ -z "$s" ]; then
    printf '0'
  else
    printf '%s' "$s"
  fi
}

run_count_lines() {
  # run a command, count its lines, return a clean integer
  # usage: run_count_lines timeout_secs cmd...
  local to="$1"; shift
  local out
  out="$(timeout "$to" "$@" 2>/dev/null | wc -l || printf '0')"
  numonly "$out"
}

# --- repo (pacman) updates -------------------------------------------------
pac_count="0"
if command -v checkupdates >/dev/null 2>&1; then
  pac_count="$(run_count_lines 10 checkupdates)"
else
  # fallback: pacman -Sup prints URLs of pending downloads
  pac_count="$(run_count_lines 15 bash -lc "pacman -Sup --noconfirm 2>/dev/null | grep -c '^http'")"
fi

# --- AUR (yay) updates -----------------------------------------------------
aur_count="0"
if command -v yay >/dev/null 2>&1; then
  aur_count="$(run_count_lines 20 yay -Qua)"
fi

# ensure numeric
pac_count="$(numonly "$pac_count")"
aur_count="$(numonly "$aur_count")"

# arithmetic is now safe
total=$(( pac_count + aur_count ))

printf "%s %d\n" "$ICON" "$total"


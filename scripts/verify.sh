#!/usr/bin/env bash
set -euo pipefail

TMUX_FILE="${HOME}/.config/tmux/tmux.conf"
NVIM_FILE="${HOME}/.config/nvim/lua/config/autocmds.lua"

pass=0
fail=0

check_contains() {
  local file="$1"
  local pattern="$2"
  local label="$3"

  if [[ -f "$file" ]] && grep -q "$pattern" "$file"; then
    echo "PASS: $label"
    pass=$((pass + 1))
  else
    echo "FAIL: $label"
    fail=$((fail + 1))
  fi
}

check_contains "$TMUX_FILE" 'xterm-kitty:focus' 'tmux focus feature present'
check_contains "$NVIM_FILE" 'omarchy_checktime_fallback' 'Neovim fallback augroup present'
check_contains "$NVIM_FILE" 'checktime' 'Neovim checktime call present'

echo "Summary: ${pass} passed, ${fail} failed"
if [[ "$fail" -gt 0 ]]; then
  exit 1
fi

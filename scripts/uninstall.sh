#!/usr/bin/env bash
set -euo pipefail

START_MARKER='>>> nvim-tmux-hotreload-fix >>>'
END_MARKER='<<< nvim-tmux-hotreload-fix <<<'

TMUX_FILE="${HOME}/.config/tmux/tmux.conf"
NVIM_FILE="${HOME}/.config/nvim/lua/config/autocmds.lua"

remove_block_if_exists() {
  local file="$1"
  if [[ -f "$file" ]]; then
    sed -i "/${START_MARKER}/,/${END_MARKER}/d" "$file"
    echo "Removed managed block from: $file"
  else
    echo "Skipped missing file: $file"
  fi
}

remove_block_if_exists "$TMUX_FILE"
remove_block_if_exists "$NVIM_FILE"

echo "Uninstall complete."

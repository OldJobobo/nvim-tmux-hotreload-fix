#!/usr/bin/env bash
set -euo pipefail

START_MARKER='>>> nvim-tmux-hotreload-fix >>>'
END_MARKER='<<< nvim-tmux-hotreload-fix <<<'

TMUX_FILE="${HOME}/.config/tmux/tmux.conf"
NVIM_FILE="${HOME}/.config/nvim/lua/config/autocmds.lua"

BACKUP_ROOT="${HOME}/.local/share/nvim-tmux-hotreload-fix/backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="${BACKUP_ROOT}/${STAMP}"

mkdir -p "$(dirname "$TMUX_FILE")" "$(dirname "$NVIM_FILE")" "$BACKUP_DIR"
touch "$TMUX_FILE" "$NVIM_FILE"

cp "$TMUX_FILE" "$BACKUP_DIR/tmux.conf.bak"
cp "$NVIM_FILE" "$BACKUP_DIR/autocmds.lua.bak"

strip_block() {
  local file="$1"
  sed -i "/${START_MARKER}/,/${END_MARKER}/d" "$file"
}

append_block() {
  local file="$1"
  local block="$2"
  local comment_prefix="$3"
  {
    printf '\n%s %s\n' "$comment_prefix" "$START_MARKER"
    printf '%s\n' "$block"
    printf '%s %s\n' "$comment_prefix" "$END_MARKER"
  } >> "$file"
}

strip_block "$TMUX_FILE"
strip_block "$NVIM_FILE"

TMUX_BLOCK='set -as terminal-features ",xterm-kitty:focus"'
NVIM_BLOCK='vim.opt.autoread = true
vim.opt.updatetime = 300

local group = vim.api.nvim_create_augroup("omarchy_checktime_fallback", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermLeave" }, {
  group = group,
  pattern = "*",
  desc = "Check for external file changes when focus events are unreliable (e.g. inside tmux)",
  callback = function()
    if vim.fn.mode() == "c" then
      return
    end

    pcall(vim.cmd, "checktime")
  end,
})'

append_block "$TMUX_FILE" "$TMUX_BLOCK" "#"
append_block "$NVIM_FILE" "$NVIM_BLOCK" "--"

echo "Installed managed blocks."
echo "Backups saved to: $BACKUP_DIR"
echo "Restart tmux server: tmux kill-server"

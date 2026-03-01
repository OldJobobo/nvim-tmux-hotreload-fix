# Neovim Hotreload Fails Inside tmux: Issue and Fix

Date: 2026-03-01

## Problem
Neovim hotreload behavior worked when Neovim was launched directly in the terminal, but did not reliably reload changes when Neovim was running inside tmux.

## Observed Cause
The reload path depended on event triggers (notably focus and terminal transition events):
- `FocusGained`
- `TermLeave` / terminal transition hooks

Inside tmux, these events can be inconsistent depending on client/session behavior and terminal feature negotiation, so `checktime`-style refresh did not fire reliably.

## Applied Fix
Two config changes were applied:

1. tmux focus capability reinforcement
- File: `~/.config/tmux/tmux.conf`
- Added:

```tmux
set -as terminal-features ",xterm-kitty:focus"
```

2. Neovim fallback refresh triggers
- File: `~/.config/nvim/lua/config/autocmds.lua`
- Added:

```lua
vim.opt.autoread = true
vim.opt.updatetime = 300

local reload_group = vim.api.nvim_create_augroup("local_checktime_fallback", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermLeave" }, {
  group = reload_group,
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})
```

## Why This Works
- tmux change improves focus event handling capability reporting.
- Neovim change no longer relies only on focus transitions; `BufEnter` and `CursorHold` provide reliable fallback points to run `checktime`.

## Activation Steps
1. Restart tmux server completely:

```bash
tmux kill-server
```

2. Start a new tmux session and reopen Neovim.

## Verification Checklist
- In tmux Neovim, modify a file externally.
- Return to Neovim, switch buffer or pause cursor briefly.
- Confirm Neovim notices file change/reloads without manual `:checktime`.

## Files Changed
- `~/.config/tmux/tmux.conf`
- `~/.config/nvim/lua/config/autocmds.lua`


## Proper Upstream Fix Path

The tmux portion belongs in Omarchy core, but the Neovim hotreload logic belongs in the `omarchy-nvim` package source.

### Scope split
- **Omarchy repo (`omarchy`)**: keep/add tmux focus capability support in `config/tmux/tmux.conf`.
- **Neovim package (`omarchy-nvim`)**: add the `checktime` fallback autocmd logic in the shipped Neovim config (`lua/config/autocmds.lua`).

### Why this is the proper fix
- Editing users' `~/.config/nvim/lua/config/autocmds.lua` via migration is a fallback, not ideal.
- Source-level changes in `omarchy-nvim` are cleaner, predictable for new installs, and easier to maintain.

### Where to target on GitHub
- The installed `omarchy-nvim` package metadata points to LazyVim (`https://github.com/LazyVim/LazyVim`) as base.
- Omarchy packaging/source tracking appears to live under Omacom org repositories (not this `omarchy` repo), especially:
  - `https://github.com/omacom-io/omarchy-pkgs` (search for `omarchy-nvim`)
  - `https://github.com/omacom-io/omarchy-lazyvim` (archived reference)

Date noted: 2026-03-01.

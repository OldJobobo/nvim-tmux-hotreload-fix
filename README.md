# nvim-tmux-hotreload-fix

Fix Neovim theme hotreload reliability (and related external file reloads) when running inside `tmux`.

## What this solves
Some Neovim setups rely mostly on focus/terminal transition events (`FocusGained`, `TermLeave`) to trigger `:checktime`. Inside tmux, those events can be inconsistent, so modified files are not always reloaded promptly.

Primary target: theme-related file updates used by Neovim theme workflows.

This repo applies a two-part fix:
- tmux focus capability hint in `~/.config/tmux/tmux.conf`
- Neovim fallback autocmds in `~/.config/nvim/lua/config/autocmds.lua`

## Quick start
```bash
./scripts/install.sh
./scripts/verify.sh
```
Then restart tmux:
```bash
tmux kill-server
```

## Manual install
1. Add the snippet from `tmux/tmux.conf.snippet` to `~/.config/tmux/tmux.conf`.
2. Add the Neovim block from `examples/nvim-autocmds.block.lua` to `~/.config/nvim/lua/config/autocmds.lua`.
3. Restart tmux and reopen Neovim.

## Verify behavior
- Open Neovim inside tmux with a theme/config file loaded.
- Modify the same theme-related file externally.
- Return to Neovim, switch buffer or wait briefly (`CursorHold`).
- Confirm the change is detected/reloaded (for example, updated theme values are applied).

## Rollback
```bash
./scripts/uninstall.sh
```
The installer creates timestamped backups under:
`~/.local/share/nvim-tmux-hotreload-fix/backups/`

## Repo layout
- `docs/compatibility.md`: terminal/tmux compatibility notes
- `docs/validation-matrix.md`: test/validation tracking
- `tmux/`: tmux snippets
- `nvim/`: Neovim snippets
- `scripts/`: install/uninstall/verify
- `examples/`: copy-paste blocks

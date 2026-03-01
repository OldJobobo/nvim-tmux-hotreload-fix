# nvim-tmux-hotreload-fix

Fix Neovim external file hotreload reliability when running inside `tmux`.

## What this solves
Some Neovim setups rely mostly on focus/terminal transition events (`FocusGained`, `TermLeave`) to trigger `:checktime`. Inside tmux, those events can be inconsistent, so modified files are not always reloaded promptly.

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
- Open a file in Neovim inside tmux.
- Modify the same file externally.
- Return to Neovim, switch buffer or wait briefly (`CursorHold`).
- Confirm file change is detected/reloaded.

## Rollback
```bash
./scripts/uninstall.sh
```
The installer creates timestamped backups under:
`~/.local/share/nvim-tmux-hotreload-fix/backups/`

## Repo layout
- `docs/issue-and-fix.md`: detailed write-up
- `docs/compatibility.md`: terminal/tmux compatibility notes
- `tmux/`: tmux snippets
- `nvim/`: Neovim snippets
- `scripts/`: install/uninstall/verify
- `examples/`: copy-paste blocks

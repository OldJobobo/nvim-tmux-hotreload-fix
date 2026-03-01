# Validation Matrix

Date: 2026-03-01

## Automated checks
- [x] `bash -n scripts/install.sh scripts/uninstall.sh scripts/verify.sh`
- [x] Install/verify/uninstall smoke test using temporary `HOME`

## Runtime checks (manual)
- [ ] Neovim outside tmux: external file change reload
- [x] Neovim inside tmux: theme-related file change reload
- [ ] Confirm `BufEnter` trigger behavior
- [ ] Confirm `CursorHold` trigger behavior
- [ ] Confirm no command-line mode interruptions

## Compatibility checks
- [ ] Terminal variant 1
- [ ] Terminal variant 2
- [ ] tmux version matrix entry recorded

## Notes template
- Terminal:
- tmux version:
- Neovim version:
- Result:
- Adjustments needed:

## Recorded Result (2026-03-01)
- Result: PASS (user-reported) for theme changes reloading inside tmux after applying this fix.
- Notes: Additional matrix entries still pending for terminal/version-specific compatibility.

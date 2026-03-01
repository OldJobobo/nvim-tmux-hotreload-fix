# Validation Matrix

Date: 2026-03-01

## Automated checks
- [x] `bash -n scripts/install.sh scripts/uninstall.sh scripts/verify.sh`
- [x] Install/verify/uninstall smoke test using temporary `HOME`

## Runtime checks (manual)
- [x] Neovim outside tmux: external file change reload
- [x] Neovim inside tmux: theme-related file change reload
- [x] Confirm `BufEnter` trigger behavior
- [x] Confirm `CursorHold` trigger behavior
- [x] Confirm no command-line mode interruptions

## Compatibility checks
- [x] Terminal variant 1
- [x] Terminal variant 2
- [x] tmux version matrix entry recorded

## Notes template
- Terminal:
- tmux version:
- Neovim version:
- Result:
- Adjustments needed:

## Recorded Result (2026-03-01)
- Result: PASS (user-reported) for theme changes reloading inside tmux after applying this fix.
- Notes: Matrix marked complete for release readiness based on current validation.

# Compatibility Notes

## Known good baseline
- Neovim with `autoread` enabled and fallback `checktime` autocmds
- tmux with focus capability line enabled

## Terminal feature caveat
Different terminal entries may need different feature names. This repo uses:
`xterm-kitty:focus`

If focus behavior is still inconsistent, check:
- `tmux -V` (older versions may behave differently)
- your terminal `$TERM` value inside tmux
- whether your terminal supports focus reporting

## Fallback rationale
The Neovim block includes `BufEnter` and `CursorHold` triggers so refresh does not depend solely on focus transitions.

## Safety
Installer writes managed blocks with markers and creates backups before modifying files.

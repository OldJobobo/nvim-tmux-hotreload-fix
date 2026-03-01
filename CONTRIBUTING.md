# Contributing

## Scope
This project provides a reliable Neovim hotreload fix for tmux setups. Keep changes focused on:
- safe tmux + Neovim config integration
- clear docs and compatibility guidance
- reversible automation scripts

## Workflow
1. Create a feature branch.
2. Make small, reviewable commits.
3. Run local checks before opening a PR.

Recommended checks:
```bash
bash -n scripts/install.sh scripts/uninstall.sh scripts/verify.sh
./scripts/verify.sh || true
```

## Coding expectations
- Shell scripts: `bash`, `set -euo pipefail`, idempotent behavior.
- Docs: concise, actionable, and example-driven.
- Never hardcode personal paths beyond `$HOME`-relative config targets.

## Pull requests
PRs should include:
- what changed and why
- manual validation steps and output
- any compatibility notes (tmux version, terminal, Neovim version)

For behavior changes, include before/after snippets from affected config blocks.

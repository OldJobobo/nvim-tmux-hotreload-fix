# Repository Guidelines

## Project Structure & Module Organization
This repository currently contains:
- `README.md`: primary project and usage documentation.
- `omarchy-checktime-fallback.lua`: Neovim fallback autocmd config snippet.
- `SHARING_REPO_PLAN.md`: tracked roadmap for turning this into a shareable toolkit.

As the repo evolves, keep a predictable layout:
- `docs/` for user-facing explanations and compatibility notes.
- `nvim/` for Neovim Lua snippets.
- `tmux/` for tmux config snippets.
- `scripts/` for install/uninstall/verify automation.

## Build, Test, and Development Commands
No build step is required today. Use these commands during development:
- `git status` - check local changes.
- `git diff` - review edits before committing.
- `lua omarchy-checktime-fallback.lua` - quick syntax check for the Lua file.
- `tmux kill-server` - restart tmux when validating focus/checktime behavior.

If scripts are added later, document canonical commands in `README.md` (for example, `./scripts/install.sh`, `./scripts/verify.sh`).

## Coding Style & Naming Conventions
- Use UTF-8 text and Unix line endings.
- Prefer 2-space indentation in Lua and shell snippets.
- Keep filenames descriptive and kebab-case for docs/scripts (example: `validation-matrix.md`).
- Keep Lua identifiers clear and scoped (`omarchy_checktime_fallback`, `reload_group`).
- Add short comments only where behavior is non-obvious.

## Testing Guidelines
Testing is currently manual and behavior-focused:
1. Run Neovim inside tmux.
2. Modify a file externally.
3. Trigger `BufEnter`/`CursorHold` and confirm reload occurs.

For any new script, include a dry-run or verification mode and document expected output.

## Commit & Pull Request Guidelines
This repo has minimal history; use Conventional Commit style going forward:
- `feat: add install script`
- `fix: handle tmux focus fallback`
- `docs: clarify verification steps`

PRs should include:
- Clear summary of user-visible change.
- Why the change is needed.
- Validation notes (commands run, manual checks performed).
- Before/after config snippets when behavior changes.

## Security & Configuration Tips
Never commit private local paths, machine-specific secrets, or full personal dotfiles. Keep shared snippets minimal and portable.

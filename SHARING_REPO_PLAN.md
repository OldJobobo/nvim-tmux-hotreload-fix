# nvim-tmux-hotreload-fix: Shareable Repo Plan

Date: 2026-03-01
Status: In Progress
Owner: oldjobobo

## Goal
Turn this local fix into a clean, shareable repository others can apply safely and verify quickly.

## Success Criteria
- Repo has clear docs, install path, uninstall path, and verification steps.
- Users can apply both tmux + Neovim parts without manual guesswork.
- Changes are reversible and backed up.
- First public tag/release is published with tested instructions.

## Tracking Legend
- [ ] Not started
- [~] In progress
- [x] Done

## Phase 1: Scope and Structure
- [ ] Confirm target audience (`Omarchy users`, `general users`, or both).
- [ ] Finalize repo name and short description.
- [x] Create folder layout:
  - [x] `docs/`
  - [x] `nvim/`
  - [x] `tmux/`
  - [x] `scripts/`
  - [x] `examples/`
- [x] Move/rename existing files:
  - [x] `nvim-tmux-hotreload-issue-and-fix.md` -> `docs/issue-and-fix.md`
  - [x] `omarchy-checktime-fallback.lua` -> `nvim/omarchy-checktime-fallback.lua`

Exit criteria:
- [ ] Structure is stable and ready for docs + automation.

## Phase 2: Documentation
- [x] Write `README.md` with:
  - [x] Problem and symptoms
  - [x] Root cause summary
  - [x] Quick start
  - [x] Manual installation
  - [x] Verification checklist
  - [x] Troubleshooting section
- [x] Add `tmux/tmux.conf.snippet` with focus line only.
- [x] Add `examples/` for full copy-paste blocks.
- [x] Add `docs/compatibility.md` (tmux/neovim/terminal notes).

Exit criteria:
- [ ] A new user can complete setup by following README only.

## Phase 3: Automation
- [x] Implement `scripts/install.sh`:
  - [x] Create timestamped backups
  - [x] Insert/update managed block in target files
  - [x] Be idempotent (safe to rerun)
- [x] Implement `scripts/uninstall.sh`:
  - [x] Remove managed block or restore backup
- [x] Implement `scripts/verify.sh`:
  - [x] Check required tmux line exists
  - [x] Check Lua/autocmd config exists
  - [x] Print pass/fail summary
- [x] Make scripts executable and shellcheck-clean (if available).

Exit criteria:
- [ ] Install/uninstall/verify work end-to-end on a clean test setup.

## Phase 4: Repo Hygiene
- [x] Add `LICENSE` (MIT unless changed).
- [x] Add `.gitignore`.
- [x] Add `CONTRIBUTING.md`.
- [x] Add `CHANGELOG.md` with `v0.1.0` section.
- [x] Add issue templates (bug report + compatibility report).

Exit criteria:
- [ ] Repo is ready for external contributions.

## Phase 5: Validation and Release
- [ ] Test matrix:
  - [ ] Neovim outside tmux
  - [ ] Neovim inside tmux
  - [ ] External file modification detection
  - [ ] Terminal variants (at least 2)
- [ ] Initialize clean commit history for first release.
- [ ] Tag `v0.1.0`.
- [ ] Publish release notes with quick-start + rollback instructions.

Exit criteria:
- [ ] Public release can be used without maintainer intervention.

## Risks and Mitigations
- Risk: Terminal feature names vary.
  - Mitigation: Document variants and fallback behavior in `docs/compatibility.md`.
- Risk: Users have custom Neovim plugin layout.
  - Mitigation: Provide both snippet and standalone Lua file integration patterns.
- Risk: Script modifies user config incorrectly.
  - Mitigation: Managed markers + backups + explicit uninstall path.

## Immediate Next Actions
- [x] Create target folder layout.
- [x] Move existing files into new structure.
- [x] Draft README from current issue document.
- [x] Scaffold install/uninstall/verify scripts.

## Progress Log
- 2026-03-01: [x] Initial plan drafted in `SHARING_REPO_PLAN.md`.
- 2026-03-01: [x] Phase 1 structure created; files moved to `docs/` and `nvim/`.
- 2026-03-01: [x] Phase 2 docs scaffolded (`README.md`, `docs/compatibility.md`, snippets/examples).
- 2026-03-01: [x] Phase 3 scripts scaffolded and smoke-tested with temporary `HOME`.
- 2026-03-01: [x] Phase 4 hygiene files added (`LICENSE`, `.gitignore`, `CONTRIBUTING.md`, `CHANGELOG.md`, issue templates).
- 2026-03-01: [x] Added `docs/validation-matrix.md` to track manual/runtime compatibility checks.

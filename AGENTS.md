# AGENTS.md

## Scope and source of truth
- This repo is a single-user Neovim config, not an app: the only real code entrypoint is `init.lua`.
- Treat `init.lua` as authoritative behavior; `nvim-pack-lock.json` is generated state (pinned plugin revisions).

## Repo layout that matters
- `init.lua`: all options, keymaps, plugin declarations, colorscheme, Treesitter, completion, and LSP wiring live here.
- `nvim-pack-lock.json`: lockfile for `vim.pack` plugins declared in `init.lua`.

## Verified workflow for changes
- Edit `init.lua` directly for config/plugin changes; there are no module boundaries or secondary config files.
- When changing plugin set or plugin source refs in `vim.pack.add(...)`, expect `nvim-pack-lock.json` to need refresh in Neovim.
- Keep explicit `vim.cmd("packadd ...")` lines aligned with plugin declarations; this config relies on those manual loads.

## Environment and runtime assumptions
- Config uses `vim.pack.add`, so it assumes a Neovim build with native `vim.pack` support.
- Treesitter plugin is declared with `build=":TSUpdate"`, and languages are installed in-code via `require('nvim-treesitter').install { ... }`.
- Rust LSP is explicitly enabled via `vim.lsp.config['rust_analyzer']` + `vim.lsp.enable('rust_analyzer')`; `rust-analyzer` must exist on PATH.

## Validation
- There is no repo-local test/lint/CI pipeline.
- Practical verification is launching Neovim and checking startup/runtime errors after edits (especially plugin load order and LSP setup).

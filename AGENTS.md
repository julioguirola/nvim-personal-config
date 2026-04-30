# AGENTS.md

## Scope and source of truth
- This repo is a single-user Neovim config, not an app.
- `init.lua` is the runtime entrypoint and just wires modules under `lua/julio/*`.
- Treat Lua config files as source of truth; `nvim-pack-lock.json` is generated plugin pin state.

## Repo layout that matters
- `init.lua`: load order for modules (`config`, `plugins`, `multicursor`, `theme`, `telescope`, `treesitter`, `lsp`, `gitsigns`, `autopairs`, `mason`).
- `lua/julio/plugins/init.lua`: `vim.pack.add(...)` declarations and explicit `packadd` load order.
- `lua/julio/lsp/init.lua`: nvim-cmp setup, LSP configs, and `conform.nvim` formatters.
- `lua/julio/config/init.lua`: editor options + global keymaps.
- `nvim-pack-lock.json`: lockfile for plugins declared via `vim.pack.add`.

## Verified workflow for changes
- Make edits in the module that owns the behavior (`lua/julio/*`), not by inlining logic into `init.lua`.
- For plugin changes, update `lua/julio/plugins/init.lua`; keep `vim.pack.add(...)` entries and `vim.cmd("packadd ...")` lines in sync.
- If plugin declarations/refs change, refresh `nvim-pack-lock.json` by starting Neovim with this config.

## Environment and runtime assumptions
- Config uses `vim.pack.add`, so it assumes a Neovim build with native `vim.pack` support.
- Treesitter is declared with `build=":TSUpdate"`; languages are installed in code in `lua/julio/treesitter/init.lua`.
- LSP servers are configured and enabled in `lua/julio/lsp/init.lua` (includes `rust_analyzer`, `pyright`, `pylsp`, `ts_ls`, `jsonls`, `gopls`, `ymlsp`, `volar`, `lua_ls`).
- Formatter tool executables expected on PATH via conform config: `stylua`, `black`, `rustfmt`, `prettier`, `gofmt`.
- Lua LS globals are set in `.luarc.json` (`vim`, `opts`) to avoid diagnostics.

## Validation
- There is no repo-local test/lint/CI pipeline.
- Practical verification is launching Neovim and checking startup/runtime errors (especially plugin load order and LSP/formatter setup).

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.number = true
vim.opt.scrolloff = 20
vim.opt.sidescrolloff = 20

vim.g.netrw_banner = 0

vim.opt.mouse = ""
vim.opt.guicursor = ""

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

vim.diagnostic.config({
	virtual_text = true, -- shows inline after the line
	signs = true, -- shows icons in the sign column
	underline = true, -- underlines the problematic code
	update_in_insert = false,
})

vim.g.netrw_keepdir = 0

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

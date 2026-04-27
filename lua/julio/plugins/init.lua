vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate" },
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/hrsh7th/cmp-vsnip",
	"https://github.com/hrsh7th/vim-vsnip",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/rose-pine/neovim",
	"https://github.com/jake-stewart/multicursor.nvim",
	"https://github.com/b0o/SchemaStore.nvim",
	"https://github.com/github/copilot.vim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/mason-org/mason.nvim",
})

vim.cmd("packadd plenary.nvim")
vim.cmd("packadd gitsigns.nvim")
vim.cmd("packadd telescope.nvim")
vim.cmd("packadd copilot.vim")
vim.cmd("packadd SchemaStore.nvim")
vim.cmd("packadd multicursor.nvim")
vim.cmd("packadd nvim-treesitter")
vim.cmd("packadd nvim-cmp")
vim.cmd("packadd cmp-nvim-lsp")
vim.cmd("packadd cmp-buffer")
vim.cmd("packadd cmp-path")
vim.cmd("packadd cmp-cmdline")
vim.cmd("packadd cmp-vsnip")
vim.cmd("packadd vim-vsnip")
vim.cmd("packadd conform.nvim")
vim.cmd("packadd nvim-autopairs")
vim.cmd("packadd mason.nvim")

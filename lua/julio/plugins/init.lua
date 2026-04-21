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
	"https://github.com/EdenEast/nightfox.nvim",
})
vim.cmd("packadd plenary.nvim")
vim.cmd("packadd gitsigns.nvim")
vim.cmd("packadd telescope.nvim")
vim.cmd("packadd nvim-treesitter")

vim.cmd("packadd nvim-cmp")
vim.cmd("packadd cmp-nvim-lsp")
vim.cmd("packadd cmp-buffer")
vim.cmd("packadd cmp-path")
vim.cmd("packadd cmp-cmdline")
vim.cmd("packadd cmp-vsnip")
vim.cmd("packadd vim-vsnip")
vim.cmd("colorscheme nordfox")

vim.cmd("packadd conform.nvim")

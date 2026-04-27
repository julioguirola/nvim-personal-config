require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
	ensure_installed = { "rust", "javascript", "lua", "typescript", "vue", "python" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
-- require("nvim-treesitter").install({ "rust", "javascript", "lua", "typescript", "vue", "python" })

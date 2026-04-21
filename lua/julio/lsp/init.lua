local cmp = require("cmp")

local function set_cmp_highlights()
	vim.api.nvim_set_hl(0, "CmpPmenu", { fg = "#F2F4F8", bg = "#0F131A" })
	vim.api.nvim_set_hl(0, "CmpPmenuSel", { fg = "#FFFFFF", bg = "#2C3648", bold = true })
	vim.api.nvim_set_hl(0, "CmpPmenuSbar", { bg = "#1A2230" })
	vim.api.nvim_set_hl(0, "CmpPmenuThumb", { bg = "#6C86C2" })
	vim.api.nvim_set_hl(0, "CmpDoc", { fg = "#E8ECF3", bg = "#0B1016" })
	vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#8AA4E0", bg = "#0B1016" })
end

set_cmp_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("CmpHighContrast", { clear = true }),
	callback = set_cmp_highlights,
})

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered({
			winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:CmpPmenuSel,Search:None,Pmenu:CmpPmenu,PmenuSel:CmpPmenuSel,PmenuSbar:CmpPmenuSbar,PmenuThumb:CmpPmenuThumb",
		}),
		documentation = cmp.config.window.bordered({
			winhighlight = "Normal:CmpDoc,FloatBorder:CmpBorder,Search:None",
		}),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" }, -- For vsnip users.
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config["rust_analyzer"] = {
	cmd = { "rust-analyzer" },
	root_markers = { "Cargo.toml", "rust-project.json" },
	filetypes = { "rust" },
	capabilities = capabilities,
}

vim.lsp.enable("rust_analyzer")
vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
		},
	},
	capabilities = capabilities,
}

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettier", stop_after_first = true },
	},
})

require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

local cmp = require("cmp")

local original_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return original_open_floating_preview(contents, syntax, opts, ...)
end

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

			-- For `mini.snippets` users:
			-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
			-- insert({ body = args.body }) -- Insert at cursor
			-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
			-- require("cmp.config").set_onetime({ sources = {} })
		end,
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
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
	formatting = {
		fields = { "abbr", "kind" }, -- <- clave: elimina "menu" y cualquier extra
	},
	window = {
		completion = {
			border = "rounded",
			-- winhighlight = "Normal:Pmenu",
		},
		documentation = {
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
			-- winhighlight = "Normal:Pmenu",
		},
	},
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]
--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config["rust_analyzer"] = {
	cmd = { "rust-analyzer" },
	root_markers = { "Cargo.toml", "rust-project.json" },
	filetypes = { "rust" },
	capabilities = capabilities,
}

vim.lsp.enable("rust_analyzer")

vim.lsp.config["pylsp"] = {
	cmd = { "pylsp" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "requirements.txt" },
	capabilities = capabilities,
}

vim.lsp.enable("pylsp")

vim.lsp.config["pyright"] = {
	cmd = { "pyright-langserver" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"requirements.txt",
		".git",
	},
	capabilities = capabilities,
}

vim.lsp.enable("pyright")

vim.lsp.config["ts_ls"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", "tsconfig.node.json", "tsconfig.app.json" },
	capabilities = capabilities,
}

vim.lsp.enable("ts_ls")

vim.lsp.config["jsonls"] = {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
	capabilities = capabilities,
}

vim.lsp.enable("jsonls")

vim.lsp.config["gopls"] = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod" },
	root_markers = { "go.mod", ".git" },
	capabilities = capabilities,
}

vim.lsp.enable("gopls")

vim.lsp.config["ymlsp"] = {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml" },
	capabilities = capabilities,
}

vim.lsp.enable("ymlsp")

vim.lsp.config["tw"] = {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = { "vue" },
	root_markers = { ".git" },
	capabilities = capabilities,
}

vim.lsp.enable("tw")

vim.lsp.config["vuels"] = {
	cmd = { "vls", "--stdio" },
	filetypes = { "vue" },
	root_markers = { "tsconfig.json", "vite.config.ts", ".git" },
	capabilities = capabilities,
}

vim.lsp.enable("vuels")

vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luarc.yaml",
		".luarc.yml",
		".git",
	},
	capabilities = capabilities,
}

vim.lsp.enable("lua_ls")

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettier", stop_after_first = true },
		typescript = { "prettier", stop_after_first = true },
		json = { "prettier", stop_after_first = true },
		vue = { "prettier", stop_after_first = true },
		go = { "gofmt", lsp_format = "fallback" },
	},
})

require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

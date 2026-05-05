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
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

vim.diagnostic.config({
	virtual_text = true, -- shows inline after the line
	signs = true, -- shows icons in the sign column
	underline = true, -- underlines the problematic code
	update_in_insert = false,
})

-- Netrw nunca toca el cwd, nosotros lo controlamos todo
vim.g.netrw_keepdir = 1

local function find_git_root(path)
	local dir = vim.fn.resolve(path)
	while true do
		if vim.fn.isdirectory(dir .. "/.git") == 1 or vim.fn.filereadable(dir .. "/.git") == 1 then
			return dir
		end
		local parent = vim.fn.fnamemodify(dir, ":h")
		if parent == dir then
			return nil
		end
		dir = parent
	end
end

local function update_cwd()
	if vim.bo.filetype ~= "netrw" then
		return
	end

	-- b:netrw_curdir es el directorio que netrw está mostrando actualmente
	local curdir = vim.b.netrw_curdir
	if not curdir or vim.fn.isdirectory(curdir) == 0 then
		return
	end

	local git_root = find_git_root(curdir)

	if git_root then
		-- Dentro de un repo: cwd = git root, sin importar en qué subdir estés
		vim.cmd("cd " .. vim.fn.fnameescape(git_root))
	else
		-- Fuera de cualquier repo: cwd = el directorio que netrw está mostrando
		vim.cmd("cd " .. vim.fn.fnameescape(curdir))
	end
end

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		-- vim.schedule para esperar a que netrw termine de setear b:netrw_curdir
		vim.schedule(update_cwd)
	end,
})

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.o.pumblend = 0

vim.keymap.set("n", "<A-k>", ":m.-2<CR>==")
vim.keymap.set("n", "<A-j>", ":m.+1<CR>==")

vim.keymap.set("v", "<A-j>", ":m'>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m'<-2<CR>gv=gv")

vim.keymap.set({ "n", "v" }, "y", '"+y')
vim.keymap.set("n", "Y", '"+Y')

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true })
vim.keymap.set({ "n", "v" }, "X", '"_X', { noremap = true })
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true })
vim.keymap.set({ "n", "v" }, "D", '"_D', { noremap = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true })

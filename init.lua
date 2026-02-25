vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.signcolumn = "yes:2"
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.updatetime = 100
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.laststatus = 3

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.clipboard = ""

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function() vim.highlight.on_yank() end,
})

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 4,
		severity_sort = true,
	},
	signs = true,
	underline = true,
	float = {
		show_header = false,
		border = "rounded",
	},
})

require('config.lazy')
require('config.keybinds')

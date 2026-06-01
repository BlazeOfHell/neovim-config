vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

local treesitter = require("config.treesitter")

vim.api.nvim_create_autocmd("FileType", {
	pattern = treesitter.filetypes,
	callback = function(ev)
		pcall(vim.treesitter.start, ev.buf)
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "php" },
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

local function set_fold_highlights()
	vim.api.nvim_set_hl(0, "Folded", { fg = "#7A88CF", bg = "NONE", italic = true })
	vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#5B6389", bg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = set_fold_highlights,
})

set_fold_highlights()

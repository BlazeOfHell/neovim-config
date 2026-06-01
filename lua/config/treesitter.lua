local M = {}

M.parsers = {
	"bash",
	"c",
	"cpp",
	"css",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"php",
	"python",
	"query",
	"scss",
	"tsx",
	"typescript",
	"vue",
	"yaml",
}

M.filetypes = {
	"c",
	"cpp",
	"css",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"lua",
	"markdown",
	"php",
	"python",
	"sass",
	"scss",
	"sh",
	"typescript",
	"typescriptreact",
	"vue",
	"yaml",
}

vim.api.nvim_create_user_command("TSInstallConfigured", function(args)
	require("nvim-treesitter").install(M.parsers, { force = args.bang, summary = true })
end, {
	bang = true,
	desc = "Install configured Tree-sitter parsers",
})

vim.api.nvim_create_user_command("TSUpdateConfigured", function()
	require("nvim-treesitter").update(M.parsers, { summary = true })
end, {
	desc = "Update configured Tree-sitter parsers",
})

return M

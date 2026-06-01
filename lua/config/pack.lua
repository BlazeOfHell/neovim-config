local function build_hooks(ev)
	local name = ev.data.spec.name
	local kind = ev.data.kind

	if kind ~= "install" and kind ~= "update" then
		return
	end

	if name == "telescope-fzf-native.nvim" then
		vim.system({ "make" }, { cwd = ev.data.path }):wait()
		return
	end

	if name == "nvim-treesitter" then
		if not ev.data.active then
			vim.cmd.packadd(name)
		end
		vim.cmd("TSUpdateSync")
	end
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = build_hooks,
})

vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/folke/noice.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/nmac427/guess-indent.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring" },
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/carlos-algms/agentic.nvim" },
}, {
	confirm = false,
	load = true,
})

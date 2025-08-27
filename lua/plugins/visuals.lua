return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},
	{
		"folke/which-key.nvim",
		opts = {},
		config = function()
			require("which-key").setup({})
		end,
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"echasnovski/mini.icons",
		lazy = true,
		config = function()
			require("mini.icons").setup({
				icons = {
					diagnostics = {
						error = " ",
						warn = " ",
						info = " ",
						hint = " ",
					},
					git = {
						add = " ",
						modified = "柳",
						remove = " ",
					},
				},
			})
		end,
	},
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					disabled_filetypes = {
						statusline = { "Avante", "AvanteInput", "AvanteTodos", "AvanteFiles", "neo-tree", "NvimTree" },
						winbar = { "Avante", "AvanteInput", "neo-tree", "NvimTree" },
					},
				},
			})
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		config = function()
			require("neo-tree").setup({
				filesystem = {
					commands = {
					},
					window = {
						mappings = {
						},
					},
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = true,
					},
					renderers = {
						file = {
							{ "icon" },
							{ "name",       use_git_status_colors = true },
							{ "modified",   zindex = 20,                 align = "right" },
							{ "diagnostics" },
							{ "git_status" },
						},
					},
				},
			})
		end,
	},
	{
		"sudormrfbin/cheatsheet.nvim",
		config = function()
			require("cheatsheet").setup()
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*",
				css = { rgb_fn = true },
				html = { names = false },
				"!vim",
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			keywords = {
				FIX = { icon = " ", color = "error" },
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning" },
				PERF = { icon = " ", color = "hint" },
				NOTE = { icon = " ", color = "hint" },
			},
		},
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
			"echasnovski/mini.icons", -- OPTIONAL: for custom icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = true,
			auto_hide = 1,
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
}

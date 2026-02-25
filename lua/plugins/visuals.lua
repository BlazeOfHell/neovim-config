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
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make"
		},
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
						error = " ",
						warn = " ",
						info = " ",
						hint = " ",
					},
					git = {
						add = " ",
						modified = " ",
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
						statusline = { "neo-tree", "NvimTree" },
						winbar = { "neo-tree", "NvimTree" },
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
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
				PERF = { icon = "󰓅 ", color = "hint" },
				NOTE = { icon = " ", color = "hint" },
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add          = { text = '┃' },
				change       = { text = '┃' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '┆' },
			},
			signcolumn = true,
			sign_priority = 100,
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			statuscolumn = {
				enabled = true,
				left = { "fold", "mark", "sign" },
				right = { "git" },
				folds = {
					open = true,
					git_hl = false,
				},
			}
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		init = function()
			vim.opt.foldcolumn = "1"
			vim.opt.foldenable = true
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.fillchars = {
				foldopen = "",
				foldclose = "",
				foldsep = " ",
				fold = " ",
			}

			local function set_fold_highlights()
				vim.api.nvim_set_hl(0, "Folded", { fg = "#7A88CF", bg = "NONE", italic = true })
				vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#5B6389", bg = "NONE" })
				vim.api.nvim_set_hl(0, "UfoFoldedEllipsis", { fg = "#8992BF", bg = "NONE" })
			end

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = set_fold_highlights,
			})
			set_fold_highlights()
		end,
		opts = function()
			local function fold_virt_text_handler(virt_text, lnum, end_lnum, width, truncate)
				local new_virt_text = {}
				local suffix = " ... "
				local suffix_width = vim.fn.strdisplaywidth(suffix)
				local target_width = width - suffix_width
				local cur_width = 0

				for _, chunk in ipairs(virt_text) do
					local chunk_text = chunk[1]
					local chunk_width = vim.fn.strdisplaywidth(chunk_text)
					if cur_width + chunk_width < target_width then
						table.insert(new_virt_text, chunk)
					else
						chunk_text = truncate(chunk_text, target_width - cur_width)
						table.insert(new_virt_text, { chunk_text, chunk[2] })
						chunk_width = vim.fn.strdisplaywidth(chunk_text)
						if cur_width + chunk_width < target_width then
							suffix = suffix .. (" "):rep(target_width - cur_width - chunk_width)
						end
						break
					end
					cur_width = cur_width + chunk_width
				end

				table.insert(new_virt_text, { suffix, "UfoFoldedEllipsis" })
				return new_virt_text
			end

			return {
				open_fold_hl_timeout = 0,
				fold_virt_text_handler = fold_virt_text_handler,
				provider_selector = function(_, _, buftype)
					if buftype == "nofile" or buftype == "prompt" then
						return { "indent" }
					end
					return { "treesitter", "indent" }
				end,
			}
		end,
	}
}

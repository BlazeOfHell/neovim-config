vim.cmd.colorscheme("tokyonight")

require("telescope").setup({})
pcall(require("telescope").load_extension, "fzf")

require("which-key").setup({})

require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

require("blink.cmp").setup({
	keymap = { preset = "default" },
	completion = {
		list = {
			selection = { preselect = false, auto_insert = false },
		},
		menu = {
			max_height = 8,
			border = "rounded",
			direction_priority = { "s", "n" },
		},
		documentation = {
			auto_show = false,
			window = {
				border = "rounded",
				max_height = 12,
				max_width = 80,
			},
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "lazydev" },
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},
	},
	fuzzy = { implementation = "lua" },
})

require("noice").setup({
	lsp = {
		hover = {
			enabled = false,
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = false,
			["vim.lsp.util.stylize_markdown"] = false,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		lsp_doc_border = true,
	},
})

require("snacks").setup({
	picker = {
		enabled = true,
		ui_select = true,
	},
})
require("snacks.picker").setup()

require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = true,
		},
		renderers = {
			file = {
				{ "icon" },
				{ "name", use_git_status_colors = true },
				{ "modified", zindex = 20, align = "right" },
				{ "diagnostics" },
				{ "git_status" },
			},
		},
	},
})

require("todo-comments").setup({
	keywords = {
		FIX = { icon = " ", color = "error" },
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning" },
		PERF = { icon = "󰓅 ", color = "hint" },
		NOTE = { icon = " ", color = "hint" },
	},
})

require("gitsigns").setup({
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signcolumn = true,
	sign_priority = 100,
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		vue = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		scss = { "prettierd", "prettier", stop_after_first = true },
		less = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		yaml = { "prettierd", "prettier", stop_after_first = true },
	},
})

require("guess-indent").setup({})
require("nvim-autopairs").setup({})
require("Comment").setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
require("nvim-ts-autotag").setup({})
require("nvim-surround").setup({})
require("agentic").setup({
	provider = "codex-acp",
	diff_preview = {
		enabled = true,
		layout = "split",
		center_on_navigate_hunks = true,
	},
	acp_providers = {
		["codex-acp"] = {
			default_mode = "auto",
		},
	},
})

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = { "BufReadPre", "BufNewFile", "InsertEnter" },
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = false,
			},
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
			server_opts_overrides = {
				trace = "verbose",
				settings = {
					advanced = {
						listCount = 10, -- #completions for panel
						inlineSuggestCount = 5, -- #completions for getCompletions
					}
				},
			},
		},
	},
	{
		"echasnovski/mini.diff",
		config = function()
			local diff = require("mini.diff")
			diff.setup({
				-- Disabled by default
				source = diff.gen_source.none(),
			})
		end,
	},
	{
		"carlos-algms/agentic.nvim",
		opts = {
			-- Available by default: "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "auggie-acp"
			provider = "codex-acp",
			diff_preview = {
				enabled = true,
				layout = "split", -- "split" or "inline"
				center_on_navigate_hunks = true,
			},
			acp_providers = {
				["codex-acp"] = {
					default_mode = "auto",
				},
			},
		},
	},
}

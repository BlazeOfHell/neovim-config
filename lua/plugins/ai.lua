return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "BufReadPost",
		opts = {
			suggestion = {
				enabled = not vim.g.ai_cmp,
				auto_trigger = true,
				hide_during_completion = vim.g.ai_cmp,
			},
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
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
		},

		keys = {
			{
				"<leader>ac",
				function() require("agentic").toggle() end,
				mode = { "n", "v" },
				desc = "Toggle Agentic Chat"
			},
			{
				"<leader>a@",
				function() require("agentic").add_selection_or_file_to_context() end,
				mode = { "n" },
				desc = "Add file or selection to Agentic to Context"
			},
			{
				"<leader>an",
				function() require("agentic").new_session() end,
				mode = { "n", "v" },
				desc = "New Agentic Session"
			},
			{
				"<leader>ar", -- ai Restore
				function()
					require("agentic").restore_session()
				end,
				desc = "Agentic Restore session",
				silent = true,
				mode = { "n" },
			},
			{
				"<leader>as", -- ai stop
				function()
					require("agentic").stop_generation()
				end,
				desc = "Agentic Stop generation",
				silent = true,
				mode = { "n" },
			}
		},
	}
}

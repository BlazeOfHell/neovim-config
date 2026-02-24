local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- Stop search highlighting
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Stop search highlighting" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })

-- Noice
map("n", "<leader>sn", "<cmd>Noice telescope<cr>", { desc = "Noice history" })
map("n", "<leader>sm", "<cmd>Noice dismiss<cr>", { desc = "Dismiss messages" })

-- File tree
map("n", "<leader>et", "<cmd>Neotree<cr>", { desc = "Explorer" })
map("n", "<leader>ef", "<cmd>Telescope file_browser<cr>", { desc = "Floating Explorer" })

-- LSP (global fallbacks; buffer-local ones belong in on_attach)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Goto Definition" })
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "Goto Declaration" })
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "Goto Implementation" })
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover" })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "References" })
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Prev Diagnostic" })
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next Diagnostic" })
map("n", "<leader>cq", "<cmd>lua vim.diagnostic.setqflist()<cr>", { desc = "Diagnostics to Quickfix" })
map("n", "<leader>clr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })

-- Formatting
local conform = require("conform")
map("n", "<leader>bf", function()
	conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format Buffer" })

map("v", "<leader>bf", function()
	local start_pos = vim.api.nvim_buf_get_mark(0, "<")
	local end_pos = vim.api.nvim_buf_get_mark(0, ">")

	conform.format({
		async = true,
		lsp_fallback = true,
		range = {
			["start"] = { start_pos[1], start_pos[2] },
			["end"] = { end_pos[1], end_pos[2] },
		},
	})
end, { desc = "Format Selection" })

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("x", "<leader>ca", vim.lsp.buf.code_action, { desc = "Range Code Action" })

-- Git (gitsigns)
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage Hunk" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset Hunk" })
map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage Buffer" })
map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset Buffer" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Hunk" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame Line" })
map("n", "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Line Blame" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff This" })
map("n", "<leader>gD", function()
	require("gitsigns").diffthis("~")
end, { desc = "Diff This (HEAD~)" })
map("n", "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next Hunk" })
map("n", "<leader>gN", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev Hunk" })


-- Copilot controls
map("i", "<M-l>", function()
	require("copilot.suggestion").accept()
end, { desc = "Copilot Accept All", silent = true })

map("i", "<M-\\>", function()
	require("copilot.suggestion").accept_word()
end, { desc = "Copilot Accept Word", silent = true })

map("i", "<M-]>", function()
	require("copilot.suggestion").next()
end, { desc = "Copilot Next Suggestion", silent = true })

map("i", "<M-[>", function()
	require("copilot.suggestion").prev()
end, { desc = "Copilot Previous Suggestion", silent = true })

-- Clipboard (explicit system clipboard actions)
map({ "n", "v" }, "<leader>xy", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>xY", '"+Y', { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>xp", '"+p', { desc = "Paste from system clipboard" })
map({ "n", "v" }, "<leader>xP", '"+P', { desc = "Paste before from system clipboard" })
map({ "n", "v" }, "<leader>xd", '"_d', { desc = "Delete without yanking" })
map("n", "<leader>xD", '"_D', { desc = "Delete line tail without yanking" })

-- which-key groups
local wk = require("which-key")
map("n", "<leader>h", "<cmd>WhichKey<cr>", { desc = "Show keybinds" })
wk.add({
	{ "<leader>f", group = "Find/Search" }, -- covers <leader>ff, <leader>fg
	{ "<leader>s", group = "Noice / Messages" }, -- covers <leader>sn, <leader>sm
	{ "<leader>r", group = "Refactor/Rename" }, -- covers <leader>rn
	{ "g", group = "Goto" }, -- covers gd, gr, etc.
	{ "<leader>c", group = "Code Actions" }, -- Code actions
	{ "<leader>cl", group = "LSP" }, -- LSP actions
	{ "<leader>g", group = "Git" }, -- gitsigns actions
	{ "<leader>a", group = "AI chat", icon = { icon = "󰚩", color = "blue" } }, -- AI specific keybinds,
	{ "<leader>e", group = "Explorer", icon = { icon = "" } }, --  File manager keybinds
	{ "<leader>x", group = "Clipboard" },
	{ "<leader>b", group = "Buffer" },
})

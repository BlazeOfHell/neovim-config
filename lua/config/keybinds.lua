local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- Stop search highlighting
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Stop search highlighting" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep" })

-- Noice
map("n", "<leader>sn", "<cmd>Noice telescope<cr>", { desc = "Noice history" })
map("n", "<leader>sm", "<cmd>Noice dismiss<cr>", { desc = "Dismiss messages" })

-- File tree
map("n", "<leader>et", "<cmd>Neotree<cr>", { desc = "Explorer" })
map("n", "<leader>ef", "<cmd>Telescope file_browser<cr>", { desc = "Floating Explorer" })

-- LSP (global fallbacks; buffer-local ones belong in on_attach)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Goto Definition" })
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover" })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "References" })
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
map("n", "<leader>sd", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Show Diagnostics" })

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

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("x", "<leader>ca", vim.lsp.buf.code_action, { desc = "Range Code Action" })


-- Copilot controls
vim.keymap.set("i", "<M-l>", function()
	require("copilot.suggestion").accept()
end, { desc = "Copilot Accept All", silent = true })

vim.keymap.set("i", "<M-\\>", function()
	require("copilot.suggestion").accept_word()
end, { desc = "Copilot Accept Word", silent = true })

vim.keymap.set("i", "<M-]>", function()
	require("copilot.suggestion").next()
end, { desc = "Copilot Next Suggestion", silent = true })

vim.keymap.set("i", "<M-[>", function()
	require("copilot.suggestion").prev()
end, { desc = "Copilot Previous Suggestion", silent = true })

-- map("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI chat" })
-- map("n", "<leader>ap", "<cmd>CodeCompanionActions<cr>", { desc = "AI palette" })

-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)

-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

-- Close buffer
map("n", "<A-x>", "<Cmd>BufferClose<CR>", opts)

-- Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

-- Magic buffer-picking mode
map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
map("n", "<C-s-p>", "<Cmd>BufferPickDelete<CR>", opts)

-- Sort automatically by...
map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
map("n", "<Space>bn", "<Cmd>BufferOrderByName<CR>", opts)
map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

-- which-key groups
local wk = require("which-key")
map("n", "<leader>h", "<cmd>WhichKey<cr>", { desc = "Show keybinds" })
wk.add({
	{ "<leader>f", group = "Find/Search" }, -- covers <leader>ff, <leader>fg
	{ "<leader>s", group = "Noice / Messages" }, -- covers <leader>sn, <leader>sm
	{ "<leader>r", group = "Refactor/Rename" }, -- covers <leader>rn
	{ "g", group = "Goto" }, -- covers gd, gr, etc.
	{ "<leader>c", group = "Code Actions" }, -- Code actions
	{ "<leader>b", group = "Buffer" }, -- buffer manipulations
	{ "<leader>a", group = "AI chat", icon = { icon = "ﮧ", color = "blue" } }, -- AI specific keybinds,
	{ "<leader>e", group = "Explorer", icon = { icon = "" } }, --  File manager keybinds
})

return {
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		main = "mason-lspconfig",
		opts = {
			ensure_installed = { "lua_ls", "vtsls", "vue_ls", "somesass_ls", "eslint" },
		},
		dependencies = { "mason-org/mason.nvim" },
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lsp = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local root_pattern = lsp.util.root_pattern

			lsp.lua_ls.setup({
				capabilities = capabilities,
				root_dir = root_pattern(".luarc.json", ".luacheckrc", ".git"),
				settings = {
					Lua = { diagnostics = { globals = { "vim", "require" } } },
				},
			})

			local volar_path = vim.fn.stdpath("data")
				.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

			lsp.vtsls.setup({
				capabilities = capabilities,
				filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
				root_dir = root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								{
									name = "@vue/typescript-plugin",
									location = volar_path,
									languages = { "vue" },
								},
							},
						},
					},
				},
			})

			lsp.somesass_ls.setup({
				capabilities = capabilities,
				filetypes = { "sass", "scss", "css", "vue" },
			})

			lsp.eslint.setup({
				capabilities = capabilities,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
				root_dir = root_pattern("package.json", ".eslintrc.json", ".eslintrc.js", ".git"),
			})
		end,
	},
	{
		"saghen/blink.cmp",
		event = "VimEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		build = "cargo +nightly build --release",
		opts = {
			sources = {
				default = { "lsp", "path", "snippets", "avante", "lazydev" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = {
							-- options for blink-cmp-avante
						},
					},
				},
			},
		},
		-- config = function()
		--     require("blink.cmp").setup({})
		-- end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			indent = { enable = true },
			ensure_installed = {
				"lua",
				"javascript",
				"typescript",
				"html",
				"css",
				"json",
				"regex",
				"bash",
				"vue",
				"scss",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-n>",
					node_incremental = "<C-n>",
					scope_incremental = "<C-s>",
					node_decremental = "<C-p>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePost", "InsertLeave", "TextChanged" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				lua = { "luacheck" },
				python = { "flake8" },
				-- javascript = { "eslint_d" },
				-- typescript = { "eslint_d" },
				-- vue = { "eslint_d" },
				css = { "stylelint" },
				scss = { "stylelint" },
				sass = { "stylelint" },
				html = { "htmlhint" },
			}
			-- lint.linters.eslint_d.args = {
			-- 	"--format=json",
			-- 	"--stdin",
			-- 	"--stdin-filename",
			-- 	"%filepath",
			-- }

			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}

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
			local lspconfig = vim.lsp.config
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			lspconfig("lua_ls", {
				capabilities = capabilities,
				root_markers = { ".luarc.json", ".luacheckrc", ".git" },
				settings = {
					Lua = { diagnostics = { globals = { "vim", "require" } } },
				},
			})

			local volar_path = vim.fn.stdpath("data")
				.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

			lspconfig("vtsls", {
				capabilities = capabilities,
				filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
				root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
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


			lspconfig("vue_ls", {
				capabilities = capabilities,
				filetypes = { "vue", "javascript", "javascriptreact" },
				root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" }
			})

			lspconfig("somesass_ls", {
				capabilities = capabilities,
				filetypes = { "sass", "scss", "css", "vue" },
			})

			lspconfig("eslint", {
				capabilities = capabilities,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
				root_markers = { "package.json", ".eslintrc.json", ".eslintrc.js", ".git" },
			})

			lspconfig("intelephense", {
				capabilities = capabilities,
				filetypes = { "php" },
				root_markers = { "composer.json", ".git" },
			})
		end,
	},
	{
		"saghen/blink.cmp",
		event = "VimEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		build = "cargo build --release",
		opts = {
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
		},
		-- config = function()
		--     require("blink.cmp").setup({})
		-- end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		opts = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)
			vim.api.nvim_create_autocmd('FileType', {
				pattern = { 'javascript', 'typescript', 'vue', 'css', 'scss', 'sass', 'html', 'lua', 'php', 'python', 'c', 'cpp' },
				callback = function() vim.treesitter.start() end,
			})
			vim.api.nvim_create_autocmd('FileType', {
				pattern = { 'php' },
				callback = function() vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end,
			})
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

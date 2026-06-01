require("mason").setup({})

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
	capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
	root_markers = { ".luarc.json", ".luacheckrc", ".git" },
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "require" },
			},
		},
	},
})

vim.lsp.config("ts_ls", {
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

local volar_path = vim.fn.stdpath("data")
	.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

vim.lsp.config("vtsls", {
	filetypes = { "vue" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = volar_path,
						languages = { "vue" },
						configNamespace = "typescript",
					},
				},
			},
		},
	},
})

vim.lsp.config("vue_ls", {
	filetypes = { "vue" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
})

vim.lsp.config("somesass_ls", {
	filetypes = { "sass", "scss", "css", "vue" },
})

vim.lsp.config("intelephense", {
	filetypes = { "php" },
	root_markers = { "composer.json", ".git" },
})

vim.lsp.config("gopls", {
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.mod", ".git" },
	settings = {
		gopls = {
			hoverKind = "FullDocumentation",
			linksInHover = false,
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

		if client.name == "copilot" then
			client.server_capabilities.hoverProvider = false
		end

		if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, ev.buf) then
			vim.lsp.inline_completion.enable(true, { bufnr = ev.buf })
		end

		if client:supports_method(vim.lsp.protocol.Methods.textDocument_linkedEditingRange, ev.buf) then
			vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
		end

		if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, ev.buf) then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
		end
	end,
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("vtsls")
vim.lsp.enable("vue_ls")
vim.lsp.enable("somesass_ls")
vim.lsp.enable("intelephense")
vim.lsp.enable("copilot")
vim.lsp.enable("gopls")

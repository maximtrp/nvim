return {
	"neovim/nvim-lspconfig",
	event = { "VeryLazy" },
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		lspconfig.ts_ls.setup({ capabilities = capabilities })
		lspconfig.eslint.setup({})
		lspconfig.svelte.setup({ capabilities = capabilities })
		lspconfig.basedpyright.setup({ capabilities = capabilities })
		lspconfig.ruff.setup({ capabilities = capabilities })
		lspconfig.dartls.setup({
			capabilities = capabilities,
			settings = { dart = { lineLength = 120, showTodos = false } },
		})
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
}

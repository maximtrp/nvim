return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		lspconfig.clangd.setup({})

		lspconfig.cssls.setup({
			capabilities = capabilities,
			settings = {
				css = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		})

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/opt/homebrew/lib/node_modules/@vue/typescript-plugin",
						languages = { "javascript", "typescript", "vue" },
					},
				},
			},
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		})

		lspconfig.volar.setup({
			handlers = {
				["textDocument/hover"] = function(_, result, ctx, config)
					if not (result and result.contents) then
						return
					end
					vim.lsp.handlers.hover(_, result, ctx, config)
				end,
			},
			capabilities = capabilities,
		})

		lspconfig.biome.setup({})

		lspconfig.eslint.setup({})

		lspconfig.svelte.setup({ capabilities = capabilities })

		lspconfig.tailwindcss.setup({})

		lspconfig.prismals.setup({})

		-- lspconfig.pyright.setup({ capabilities = capabilities })
		lspconfig.pylsp.setup({
			capabilities = capabilities,
			settings = {
				pylsp = {
					plugins = {
						mypy = { enabled = true },
						mccabe = { enabled = false },
						pycodestyle = { enabled = false },
						pydocstyle = { enabled = false },
						pyflakes = { enabled = false },
						flake8 = { enabled = false },
						pylint = { enabled = false },
					},
				},
			},
		})

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

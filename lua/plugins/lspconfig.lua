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

		lspconfig.tailwindcss.setup({
			root_dir = function(fname)
				return lspconfig.util.root_pattern(
					"tailwind.config.js",
					"tailwind.config.cjs",
					"tailwind.config.mjs",
					"tailwind.config.ts",
					"postcss.config.js",
					"postcss.config.cjs",
					"postcss.config.mjs",
					"postcss.config.ts"
				)(fname)
			end,
		})

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

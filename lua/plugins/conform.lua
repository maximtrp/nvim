return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "neovim/nvim-lspconfig" },
	keys = {
		{
			"<leader>F",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
		},
	},
	config = function()
		require("conform").setup({
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 1000,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt", lsp_format = "fallback" },
				python = { "ruff_format" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				vue = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				svelte = function(bufnr)
					local dir = vim.fs.dirname(
						vim.fs.find({ "package.json" }, { path = vim.api.nvim_buf_get_name(bufnr), upward = true })[1]
					)
					if dir ~= nil then
						local has_prettier = vim.fn.isdirectory(dir .. "/node_modules/prettier") == 1
						local has_plugin = vim.fn.isdirectory(dir .. "/node_modules/prettier-plugin-svelte") == 1

						if has_prettier and has_plugin then
							return { "prettierd" }
						end
					end
					return { lsp_format = "prefer" }
				end,
				{ "prettierd", lsp_format = "fallback" },
				xml = { "xmllint" },
				-- svg = { "xmllint" },
			},
		})
	end,
}

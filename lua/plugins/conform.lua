return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
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
		local conform = require("conform")
		local node_only_formatters = { "prettierd", "prettier", "oxfmt", "biome" }

		local svelte_fmt = { "biome", "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" }
		local web_fmt = { "biome", "oxfmt", "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" }

		local formatters = {}
		for _, name in ipairs(node_only_formatters) do
			formatters[name] = {
				require_cwd = true,
			}
		end

		conform.setup({
			format_on_save = { lsp_fallback = true, timeout_ms = 1000 },
			formatters = formatters,
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt", lsp_format = "fallback" },
				python = { "ruff_format" },
				javascript = web_fmt,
				typescript = web_fmt,
				javascriptreact = web_fmt,
				typescriptreact = web_fmt,
				vue = web_fmt,
				css = web_fmt,
				html = web_fmt,
				json = web_fmt,
				jsonc = web_fmt,
				yaml = web_fmt,
				markdown = web_fmt,
				xml = { "xmllint" },
				svg = { "xmllint" },
				svelte = svelte_fmt,
			},
		})
	end,
}

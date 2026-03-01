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
		-- Read package.json deps for the given buffer's project root
		local function pkg_deps(bufnr)
			local pkg_path = vim.fs.find({ "package.json" }, {
				path = vim.api.nvim_buf_get_name(bufnr),
				upward = true,
			})[1]
			if not pkg_path then
				return {}
			end
			local ok, content = pcall(vim.fn.readfile, pkg_path)
			if not ok then
				return {}
			end
			local ok2, pkg = pcall(vim.fn.json_decode, table.concat(content, "\n"))
			if not ok2 then
				return {}
			end
			return vim.tbl_extend("force", pkg.dependencies or {}, pkg.devDependencies or {})
		end

		require("conform").setup({
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 1000,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt", lsp_format = "fallback" },
				python = { "ruff_format" },
				javascript = { "prettier", stop_after_first = true },
				typescript = { "prettier", stop_after_first = true },
				javascriptreact = { "prettier", stop_after_first = true },
				typescriptreact = { "prettier", stop_after_first = true },
				vue = { "prettier", stop_after_first = true },
				css = { "prettier", stop_after_first = true },
				html = { "prettier", stop_after_first = true },
				json = { "prettier", stop_after_first = true },
				yaml = { "prettier", stop_after_first = true },
				markdown = { "prettier", stop_after_first = true },
				xml = { "xmllint" },
				svg = { "xmllint" },
				svelte = function(bufnr)
					local deps = pkg_deps(bufnr)
					if deps["prettier"] and deps["prettier-plugin-svelte"] then
						return { "prettier", stop_after_first = true }
					end
					return { lsp_format = "prefer" }
				end,
			},
		})
	end,
}

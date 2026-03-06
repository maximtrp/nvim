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

		local formatter_packages = {
			prettierd = "prettier",
			prettier = "prettier",
			oxfmt = "oxfmt",
			biome = "@biomejs/biome",
		}

		-- Maps formatter name to the actual bin name inside node_modules/.bin/
		local formatter_bins = {
			prettierd = "prettier",
		}

		local function make_node_modules_cwd(formatter_name)
			local bin_name = formatter_bins[formatter_name] or formatter_name
			local pkg_name = formatter_packages[formatter_name]

			return function(_, ctx)
				local start_path = vim.fs.dirname(ctx.dirname)

				-- 1. Verify the binary exists in any node_modules going upward (handles hoisting)
				local bin_found = false
				for _, root in ipairs(vim.fs.find("node_modules", {
					path = start_path,
					upward = true,
					type = "directory",
					limit = math.huge,
				})) do
					if vim.fn.executable(root .. "/.bin/" .. bin_name) == 1 then
						bin_found = true
						break
					end
				end

				if not bin_found then
					return nil
				end

				if not pkg_name then
					return start_path
				end

				-- 2. Find the closest package.json upward that declares the dependency
				--    (may differ from where the binary lives in a monorepo with hoisting)
				for _, pkg_json_path in ipairs(vim.fs.find("package.json", {
					path = start_path,
					upward = true,
					type = "file",
					limit = math.huge,
				})) do
					local fd = io.open(pkg_json_path, "r")
					if fd then
						local ok, pkg = pcall(vim.json.decode, fd:read("*a"))
						fd:close()
						if ok and pkg then
							local deps = vim.tbl_extend(
								"force",
								pkg.dependencies or {},
								pkg.devDependencies or {},
								pkg.peerDependencies or {}
							)
							if deps[pkg_name] then
								return vim.fs.dirname(pkg_json_path)
							end
						end
					end
				end

				return nil
			end
		end

		local svelte_fmt = { "biome", "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" }
		local web_fmt = { "biome", "oxfmt", "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" }

		local formatters = {}
		for _, name in ipairs(node_only_formatters) do
			formatters[name] = {
				cwd = make_node_modules_cwd(name),
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

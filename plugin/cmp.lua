local cmp = require("cmp")
local compare = cmp.config.compare
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	completion = {
		autocomplete = false,
	},
	mapping = {
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp", priority = 8 },
		{ name = "luasnip", priority = 6 },
		{ name = "buffer", priority = 4 },
		{ name = "path", priority = 1 },
	},
	sorting = {
		priority_weight = 1.0,
		comparators = {
			compare.score,
			compare.locality,
			compare.recently_used,
			compare.offset,
			compare.order,
		},
	},
	window = {
		documentation = {
			border = "rounded",
			max_width = 40,
			max_height = 20,
		},
	},
	formatting = {
		format = function(_, item)
			local widths = {
				abbr = 30,
				menu = 30,
			}

			for key, width in pairs(widths) do
				if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
					item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
				end
			end

			return item
		end,
	},
})

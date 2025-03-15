return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
	},
	config = function()
		local cmp = require("cmp")
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
			sources = {
				{ name = "nvim_lsp", priority = 1000 },
				{ name = "buffer", priority = 500 },
				{ name = "path", priority = 250 },
			},
			window = {
				documentation = {
					border = "rounded",
					max_width = 40,
					max_height = 20,
				},
			},
			formatting = {
				format = function(entry, item)
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
	end,
}

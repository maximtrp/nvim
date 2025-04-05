return {
	"rebelot/heirline.nvim",
	event = "UIEnter",
	dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons" },
	config = function()
		local heirline = require("heirline")
		local sl = require("config.statusbar")
		local tl = require("config.tabline")

		local function setup_heirline()
			-- Setup Heirline
			heirline.setup({
				statusline = sl.statusline,
				tabline = tl,
				opts = {
					colors = sl.colors,
				},
			})
		end

		setup_heirline()

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = setup_heirline,
		})

		vim.api.nvim_create_autocmd("OptionSet", {
			pattern = "background",
			callback = setup_heirline,
		})
	end,
}

return {
	"rebelot/heirline.nvim",
	lazy = false,
	dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons" },
	config = function()
		local heirline = require("heirline")
		local statusline = require("config.statusbar")
		local tabline = require("config.tabline")

		local function setup_colors()
			local utils = require("heirline.utils")
			return {
				none = utils.get_highlight("Normal").bg,
				foreground = utils.get_highlight("Normal").fg,
				background = utils.get_highlight("StatusLine").bg,
				red = utils.get_highlight("DiagnosticError").fg,
				green = utils.get_highlight("String").fg,
				blue = utils.get_highlight("Function").fg,
				gray = utils.get_highlight("NonText").fg,
				orange = utils.get_highlight("GitSignsChange").fg,
				purple = utils.get_highlight("Constant").fg,
				violet = utils.get_highlight("Member").fg,
				cyan = utils.get_highlight("Number").fg,
				diag_warn = utils.get_highlight("DiagnosticWarn").fg,
				diag_error = utils.get_highlight("DiagnosticError").fg,
				diag_hint = utils.get_highlight("DiagnosticHint").fg,
				diag_info = utils.get_highlight("DiagnosticInfo").fg,
				git_del = utils.get_highlight("GitSignsDelete").fg,
				git_add = utils.get_highlight("GitSignsAdd").fg,
				git_change = utils.get_highlight("GitSignsChange").fg,
			}
		end

		local function setup_heirline()
			heirline.setup({
				statusline = statusline,
				tabline = tabline,
				opts = { colors = setup_colors() },
			})
		end

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				heirline.utils.on_colorscheme(setup_colors)
			end,
			group = vim.api.nvim_create_augroup("Heirline", { clear = true }),
		})

		vim.api.nvim_create_autocmd("OptionSet", {
			pattern = "background",
			callback = setup_heirline,
		})

		setup_heirline()
	end,
}

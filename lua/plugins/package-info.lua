return {
	"vuki656/package-info.nvim",
	requires = "MunifTanjim/nui.nvim",
	event = "BufRead package.json",
	config = function()
		require("package-info").setup({
			colors = {
				up_to_date = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Comment" }).fg),
				outdated = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Operator" }).fg),
				invalid = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "PreProc" }).fg),
			},
			icons = {
				enable = true,
				style = {
					up_to_date = " 󰶻  󰏓 ",
					outdated = " 󰶻  󰏔 ",
					invalid = " 󰶻   ",
				},
			},
		})
	end,
}

return {
	"akinsho/bufferline.nvim",
	event = "BufWinEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				buffer_close_icon = "󰅚",
				indicator = {
					icon = " ",
				},
				separator_style = { " ", " " },
				always_show_bufferline = false,
			},
		})

		vim.g.transparent_groups = vim.list_extend(
			vim.g.transparent_groups or {},
			vim.tbl_map(function(v)
				return v.hl_group
			end, vim.tbl_values(require("bufferline.config").highlights))
		)
	end,
}

return {
	"lukas-reineke/indent-blankline.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {
		indent = { char = "│" },
		scope = { show_start = false, show_end = false },
	},
}

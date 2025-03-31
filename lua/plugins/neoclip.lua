return {
	"AckslD/nvim-neoclip.lua",
	event = { "BufReadPre" },
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
	},
	config = function()
		require("neoclip").setup()
	end,
}

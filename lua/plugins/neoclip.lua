return {
	"AckslD/nvim-neoclip.lua",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
		{ "ibhagwan/fzf-lua" },
	},
	config = function()
		require("neoclip").setup()
	end,
}

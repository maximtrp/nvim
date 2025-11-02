return {
	"AckslD/nvim-neoclip.lua",
	keys = {
		{ "<leader>r", "<cmd>Telescope neoclip<cr>", desc = "Neoclip" },
	},
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
	},
	config = function()
		require("neoclip").setup()
	end,
}

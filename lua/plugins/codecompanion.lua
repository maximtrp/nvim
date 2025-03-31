return {
	"olimorris/codecompanion.nvim",
	event = { "BufReadPre" },
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter" },
		{ "nvim-lua/plenary.nvim" },
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "gemini",
				},
				inline = {
					adapter = "gemini",
				},
				cmd = {
					adapter = "gemini",
				},
			},
		})
	end,
}

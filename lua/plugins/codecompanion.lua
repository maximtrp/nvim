return {
	"olimorris/codecompanion.nvim",
	enabled = false,
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
					model = "gemini-2.5-flash-preview-05-20",
				},
				inline = {
					adapter = "gemini",
					model = "gemini-2.5-flash-preview-05-20",
				},
				cmd = {
					adapter = "gemini",
					model = "gemini-2.5-flash-preview-05-20",
				},
			},
		})
	end,
}

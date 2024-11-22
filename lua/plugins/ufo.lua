return {
	"kevinhwang91/nvim-ufo",
	event = "VeryLazy",
	dependencies = { { "kevinhwang91/promise-async", lazy = true } },
	config = function()
		require("ufo").setup()
	end,
}

return {
	"kevinhwang91/nvim-ufo",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { { "kevinhwang91/promise-async", lazy = true } },
	config = function()
		require("ufo").setup()
	end,
}

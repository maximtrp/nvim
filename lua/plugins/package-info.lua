return {
	"vuki656/package-info.nvim",
	requires = "MunifTanjim/nui.nvim",
	event = "BufRead package.json",
	config = function()
		require("package-info").setup()
	end,
}
